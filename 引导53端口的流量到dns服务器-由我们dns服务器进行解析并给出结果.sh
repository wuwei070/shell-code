#有空自己做实验测试下
iptables -t nat -I PREROUTING -p udp -m udp --dport 53 -j DNAT --to-destination 202.111.38.106:53