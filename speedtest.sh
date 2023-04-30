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
        echo "Invalid option: -$OPTARG exiting" >&2
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument" >&2
        exit 1
        ;;
    esac
done

duration=${duration:=1h}
interval=${interval:=10m}

#######################################
# Set duration
#######################################

int_duration=$(echo "${duration}" | sed 's/.$//')
unit_duration=$(echo "${duration}" | sed 's/^.*\(.$\)/\1/')

if echo "$unit_duration" | grep -q "^s$"; then
    :
elif echo "$unit_duration" | grep -q "^m$"; then
    int_duration=$((int_duration * 60))
elif echo "$unit_duration" | grep -q "^h$"; then
    int_duration=$((int_duration * 60 * 60))
elif echo "$unit_duration" | grep -q "^d$"; then
    int_duration=$((int_duration * 60 * 60 * 24))
elif echo "$unit_duration" | grep -q "^w$"; then
    int_duration=$((int_duration * 60 * 60 * 24 * 7))
else
    echo "ERROR: Invalid duration unit" && exit 1
fi

#######################################
# Set interval
#######################################

int_interval=$(echo "${interval}" | sed 's/.$//')
unit_interval=$(echo "${interval}" | sed 's/^.*\(.$\)/\1/')

if echo "$unit_interval" | grep -q "^s$"; then
    :
elif echo "$unit_interval" | grep -q "^m$"; then
    int_interval=$((int_interval * 60))
elif echo "$unit_interval" | grep -q "^h$"; then
    int_interval=$((int_interval * 60 * 60))
elif echo "$unit_interval" | grep -q "^d$"; then
    int_interval=$((int_interval * 60 * 60 * 24))
elif echo "$unit_interval" | grep -q "^w$"; then
    int_interval=$((int_interval * 60 * 60 * 24 * 7))
else
    echo "ERROR: Invalid interval unit" && exit 1
fi

if [ "$int_interval" -gt "$int_duration" ]; then
    echo "ERROR: Interval must be less than duration" && exit 1
fi

#######################################
# Main
#######################################

unixtime_current=$(date +%s)
unixtime_end=$((unixtime_current + int_duration))

mkdir -p "$(dirname "$output")"
echo "date,Download(Mbit/s),Upload(Mbit/s)" >"$output"

while [ "$unixtime_current" -lt "$unixtime_end" ]; do
    now=$(date "+%Y-%m-%d %H:%M:%S")
    unixtime_speedtest=$(date +%s)
    speed=$(speedtest-cli --secure --simple 2>/dev/null)
    if [ -z "$speed" ]; then
        echo "${now},0,0" >>"$output"
    else
        echo "$speed" |
            sed 1d |
            cut -d " " -f 2 |
            paste - - |
            # sed -e "s/ms /ms\t/" -e "s|Mbit/s |Mbit/s\t|g" |
            # cut -f 2- |
            # paste - - - |
            tr "\t" "," |
            sed "s|^|${now},|" >>"$output"
    fi
    unixtime_speedtest=$(($(date +%s) - unixtime_speedtest))
    if [ $((int_interval - unixtime_speedtest)) -gt 0 ]; then
        sleep $((int_interval - unixtime_speedtest))
    fi
    unixtime_current=$(date +%s)
done
