#!/bin/bash

test_name="$0"

#######################################
# Set duration
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

if [ "$(format_time 10s)" -ne 10 ]; then
    echo "${test_name} is faild"
    exit 1
fi

if [ "$(format_time 10m)" -ne 600 ]; then
    echo "${test_name} is faild"
    exit 1
fi

if [ "$(format_time 1h)" -ne 3600 ]; then
    echo "${test_name} is faild"
    exit 1
fi

if [ "$(format_time 1d)" -ne 86400 ]; then
    echo "${test_name} is faild"
    exit 1
fi

if [ "$(format_time 1w)" -ne 604800 ]; then
    echo "${test_name} is faild"
    exit 1
fi

echo "${test_name} is passed"
exit 0
