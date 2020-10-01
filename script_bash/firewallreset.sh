#!/bin/sh

IPTABLES=/sbin/IPTABLES
ip_addrWeb=10.42.0.1

#Supprime les tables internet crée pour la redirection
$IPTABLES -t nat -D internet PREROUTING -m mark --mark 99 -p tcp --dport 80 -j DNAT --to-destination $ip_addrWeb
$IPTABLES -t nat -D internet PREROUTING -m mark --mark 99 -p tcp --dport 443 -j DNAT --to-destination $ip_addrWeb