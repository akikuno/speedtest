#!/bin/bash

#######################################
# Preprocessing
#######################################

type speedtest-cli >/dev/null 2>&1 || { echo "ERROR: Install speedtest-cli" && exit 1; }

while getopts :o:d:i: OPT; do
    case $OPT in
    o) output="${OPTARG}" ;;
    d) duration="${OPTARG}" ;;
    i) interval=${OPTARG} ;;
    \?)
        echo "ERROR: Invalid option: -$OPTARG exiting" >&2
        exit 1
        ;;
    :)
        echo "ERORR: Option -$OPTARG requires an argument" >&2
        exit 1
        ;;
    esac
done

[ -z "${output}" ] && { echo "ERROR: Output file is not specified" >&2 && exit 1; }
duration=${duration:=1h}
interval=${interval:=10m}

#######################################
# Format time
#######################################

format_time() {
    local argument=$1
    local result
    time=$(echo "${argument}" | sed 's/.$//')
    unit=$(echo "${argument}" | sed 's/^.*\(.$\)/\1/')

    if echo "$unit" | grep -q "^s$"; then
        result="$time"
    elif echo "$unit" | grep -q "^m$"; then
        result=$((time * 60))
    elif echo "$unit" | grep -q "^h$"; then
        result=$((time * 60 * 60))
    elif echo "$unit" | grep -q "^d$"; then
        result=$((time * 60 * 60 * 24))
    elif echo "$unit" | grep -q "^w$"; then
        result=$((time * 60 * 60 * 24 * 7))
    else
        echo "ERROR: Invalid duration unit" && exit 1
    fi

    echo "$result"
}

int_duration=$(format_time "${duration}")
int_interval=$(format_time "${interval}")

[ "$int_duration" -lt "$int_interval" ] && { echo "ERROR: Duration must be greater than interval" >&2 && exit 1; }

#######################################
# Main
#######################################

unixtime_current=$(date +%s)
unixtime_end=$((unixtime_current + int_duration))

mkdir -p "$(dirname "$output")"
echo "Date,Download(Mbit/s),Upload(Mbit/s)" >"$output"

while [ "$unixtime_current" -lt "$unixtime_end" ]; do
    now=$(date "+%Y-%m-%d %H:%M:%S")
    unixtime_speedtest=$(date +%s)
    speed=$(speedtest-cli --secure --simple --timeout 5 2>/dev/null)
    if [ -z "$speed" ]; then
        echo "${now},0,0" >>"$output"
    else
        echo "$speed" |
            sed 1d |
            cut -d " " -f 2 |
            paste - - |
            tr "\t" "," |
            sed "s|^|${now},|" >>"$output"
    fi
    unixtime_speedtest=$(($(date +%s) - unixtime_speedtest))
    if [ $((int_interval - unixtime_speedtest)) -gt 0 ]; then
        sleep $((int_interval - unixtime_speedtest))
    fi
    unixtime_current=$(date +%s)
done
