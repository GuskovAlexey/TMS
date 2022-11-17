#!/bin/bash
START=$(date +%s%N)

# начало скрипта
sudo find  / -name test -type f
# конец скрипта

END=$(date +%s%N)
DIFF=$((($END - $START)/1000000))
echo "It took $DIFF milliseconds"
