#!/bin/bash
# 2019/10/09,by xuqb,First release
#检测ddns是否会解析异常。脚本会判断是线路故障还是配置的递归dns异常或者还是说服务异常
export SYSTEMCTL_SKIP_REDIRECT=1

#判断ddns是否能解析
check_dnspod_resolv() {
    dig @127.0.0.1 www.qq.com +short +time=1  > /dev/null 
}

#判断ddns服务是否异常 
chk_dnspod_service() {
    service dnspod status | grep -q running
    if [ $? -ne 0 ]; then
        echo "service dnspod is unnormal"
        exit 1
    fi
} 

#判断回源是否异常
check_line() {
    ping 114.114.114.114 > /dev/null
}

#判断主备线路是否全断
check_Primary_Backup_line() {
    if [ ! -f /etc/init.d/link_probe ] || [ ! -d /usr/local/link_probe/ ] ;then
        :
    fi

    ##获取3分钟的时间格式
    SPLITER=""
    FILTER=""
    for (( i = 1; i <=3; i++ ))
    do
        FILTER="`date -d "-$i minute" +"%Y/%m/%d %H:%M"`$SPLITER$FILTER"
        SPLITER="|"
    done

    sum_count=$(tail -n 10000 /usr/local/link_probe/var/log/link_probe.log.0 | egrep "${FILTER}" | grep "SHELL: .*_link" | wc -l)
    error_count=$(tail -n 10000 /usr/local/link_probe/var/log/link_probe.log.0 | egrep "${FILTER}" | grep "SHELL: .*_link" | grep ERROR | wc -l)
    if [ ${sum_count} -gt 5 ] && [ ${sum_count} -eq ${error_count} ]; then
        echo "Primary_link and Backup_link is cut off in three minutes!!!"
        exit 1
    fi 
    
}

#判断配置的递归dns是否都不能解析
check_dns_recursive() {
    DNS=`grep nameserver /usr/local/dnspod/etc/sr.conf |head -n 1 |awk -F'>' '{print $2}' |awk -F'<' '{print $1}' | tr ',' ' '`
    for i in $DNS; do
        dns_num+=1 
        dig @$i www.qq.com +short +time=1 > /dev/null || err_dns+=1
    done  
    if [ $dns_num == $err_dns ]; then
        echo 'all dns recursive is error'
        exit 1
    fi
}

main() {
    if check_dnspod_resolv ; then
        echo 'dnspod resolve is normal'
        exit 0
    else
       chk_dnspod_service && check_Primary_Backup_line && check_dns_recursive 
    fi
}
main 