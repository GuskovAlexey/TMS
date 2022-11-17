#!/bin/bash

#First variant
file=$1
command=`grep -io "continuous integration" "$file" | wc -l`
echo "Grep: Amound of words =$command"

#Second variant
file=$1
command=`ack -chi "continuous integration" "$file"`
echo "ACK: Amound of words  =$command"

# Change words
sed -i.bak 's/continuous integration/CI/g;s/Continuous integration/CI/g' $file 


