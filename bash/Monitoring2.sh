#!/bin/bash

# show process
user=`whoami`
command=`ps -fu "$user" | wc -l`
process=$(($command-1))
echo "Processes for $user = $process"

# loading CPU %
cpu=`ps -aux | awk '{a+=$3} END {print a}'`
echo "CPU load now = $cpu%"

# Memory
available=`free --mega | grep 'Mem:' | awk '{print $7}'`
total=`free --mega | grep 'Mem:' | awk '{print $2}'`
used=`free --mega | grep 'Mem:' | awk '{print $3}'`
free=`free --mega | grep 'Mem:' | awk '{print $4}'`
echo "Memory size: Available=$available MB, Total=$total MB, Used=$used MB, Free=$free MB"

# Connection

if [ -n "$1" ]; then
amount_t=`ss -n sport = :"$1" | wc -l`
amount_conn_ports=$(($amount_t-1))
echo "Amount connections for port $1 = $amount_conn_ports"
else
amount_all_t=`ss -n | wc -l`
amount_all_ports=$(($amount_all_t-1))
echo "Amount all ports with connections $amount_all_ports"
fi

# Disk size

summ_size=`lsblk -b | awk '{a+=$4} END {print a}'`
echo "Summ size disk - $summ_size B and $(($summ_size/1024)) KB and $(($summ_size/1048576)) MB and $(($summ_size/1073741824)) GB"
