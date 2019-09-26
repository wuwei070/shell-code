#!/bin/bash
LOG_FILE=/tmp/sys-info.txt
date +%Y-%m-%d' '%H:%M:%S >> $LOG_FILE
w >> $LOG_FILE
uptime >> $LOG_FILE
echo '' >> $LOG_FILE