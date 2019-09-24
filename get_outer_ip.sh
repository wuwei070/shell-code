#!/bin/bash
#查询linux服务器出口ip
$E_XCD=65
cd /tmp || { echo "Cannot change to necessary directory." >&2 exit $E_XCD; }
rm -f /tmp/getip* ;wget -q  "http://members.3322.org/dyndns/getip"  ; cat getip* 

