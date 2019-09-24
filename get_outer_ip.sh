#!/bin/bash
#查询linux服务器出口ip
cd /tmp;rm -f /tmp/getip* ;wget -q  "http://members.3322.org/dyndns/getip"  ; cat getip* 

