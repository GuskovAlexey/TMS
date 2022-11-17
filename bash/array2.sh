#!/bin/bash

array=(3 2 1)
array2=(1 2 3)
array3=(5 6 7)
for (( i=0; i<${#array[@]}; i++ ))
do
        echo "${array[$i]}${array2[$i]}${array3[$1]}"
done
