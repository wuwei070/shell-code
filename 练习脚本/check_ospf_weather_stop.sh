#!/bin/bash
# 2019/10/09,by xuqb,First release
#检测ospf是否停止了
export SYSTEMCTL_SKIP_REDIRECT=1

service ospfd status | grep stopped 
if [ $? -eq 0 ]; then
    echo 'ospf is stop'
    exit 1
else
    echo "ospf is running"
    exit 0
fi 