#!/bin/bash

test_name="$0"

#######################################
# No output file
#######################################
sh ./speedtest.sh 2>test_result.txt
echo "ERROR: Output file is not specified" >test_answer.txt

if cmp --silent test_result.txt test_answer.txt; then
    echo "${test_name} is passed"
    rm test_*.txt
else
    echo "${test_name} is faild"
    rm test_*.txt
    exit 1
fi
