#!/bin/sh


iptables -t filter -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A OUTPUT -p tcp -m multiport --dports 443,80,1024,5555,60002 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp -j DROP


