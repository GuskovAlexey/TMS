#!/bin/bash
# show process 
ps -U $USER


#show cpu %
#sudo apt install sysstat
mpstat

#show mem 
free

#show connections
netstat -ap

#show disk
df -h