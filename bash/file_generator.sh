#!/bin/bash

name_dir="$1"
depth_gen="$2"

mkdir -p "$name_dir"
a="/home/$name_dir"

for (( i=1 ; i<="$depth_gen" ; i++ )); do
    a+="/$i"
    mkdir -p "$a"
    cd "$a"
    touch "$i".txt
done










