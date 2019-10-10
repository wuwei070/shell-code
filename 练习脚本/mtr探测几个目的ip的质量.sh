#!/bin/bash
# 2019/10/09,by xuqb,First release

ips='183.2.199.50 203.88.218.201 103.24.178.4 202.96.134.166'
tmp_file=/tmp/mtr.txt
while true
do
    for ip in $ips; do
        date +"%Y%m%d %H:%M:%S" >> $tmp_file
        mtr -rni 0.1 $ip >> $tmp_file
        echo ' ' >> $tmp_file
    done
    sleep 10
done 