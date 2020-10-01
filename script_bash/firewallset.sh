#!/bin/bash

###This file initialize the rule in the
#firewall using iptables


IPTABLES=/sbin/iptables

getarp(){
    #This script will show the mac adress of the interface
    #passed in argument
    if [ $# -le 1 ]
    then
        ip addr show $1 | grep ether | cut -d\  -f 6
    else
        echo "Mauvais argument... entrer le nom de l'interface"
    fi
}

#Configurations
eth_local='wlp3s0'
eth_internet='enp0s25'
ip_addrWeb='10.42.0.1'
#ip_addrWeb=192.168.10.13
path='/home/raph35/'
path_user=$path'user'
path_macAddr=$path'macUser'
#mac_web='a4:4e:31:81:74:c8'
#Met a jour la liste des utilisateurs encore connecté dans le fichier /home/raph35/macUser
/home/raph35/Captive_portal/update_user.sh

#creation d'un nouveau chaine internet
#Pour authentifier les utilisateurs connectes

$IPTABLES -t mangle -F
$IPTABLES -t mangle -X
$IPTABLES -t nat -F
#$IPTABLES -F
#$IPTABLES -X
echo "Suppression des chaines par defaut"

$IPTABLES -N internet -t mangle
echo "Chaine internet créer"

#Envoi tous les traffics vers la chaine internet
$IPTABLES -t mangle -A PREROUTING -j internet

$IPTABLES -t mangle -A internet -i $eth_internet -j RETURN
$IPTABLES -t mangle -A internet -i lo -j RETURN
$IPTABLES -t mangle -A internet --destination 192.168.10.45 -j RETURN
#$IPTABLES -t mangle -A internet -m mac --mac-source e0:9d:31:08:87:24 -j RETURN
# Ajout des utilisateurs connectés
while IFS=/ read name mac autre
do
    echo "$mac"
    $IPTABLES -t mangle -A internet -m mac --mac-source $mac -j RETURN
done < $path_macAddr

# Marque les adresses MAC non trouvées dans la liste . Mark the packet 99
$IPTABLES -t mangle -A internet -j MARK --set-mark 99

# Redirection des requettes http des utilisateurs non autorisée vers la page de login
$IPTABLES -t nat -A PREROUTING -m mark --mark 99 -p tcp --dport 80 -j DNAT --to-destination $ip_addrWeb
$IPTABLES -t nat -A PREROUTING -m mark --mark 99 -p tcp --dport 443 -j DNAT --to-destination $ip_addrWeb

# authorise les requettes dns servers
$IPTABLES  -A FORWARD -p udp --dport 53 -j ACCEPT

# Accepte les connections entrantes
$IPTABLES -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
$IPTABLES -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
$IPTABLES -t filter -A INPUT -p udp --dport 68 -j ACCEPT
$IPTABLES -t filter -A INPUT -p udp --dport 67 -j ACCEPT
$IPTABLES -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
$IPTABLES -t filter -A INPUT -m mark --mark 99 -j DROP

#Authorise la connection à l'internet
echo "1" >/proc/sys/net/ipv4/ip_forward
$IPTABLES -A FORWARD -i $eth_internet -o $eth_local -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A FORWARD -i $eth_local -o $eth_internet -j ACCEPT
$IPTABLES -t nat -A POSTROUTING -o $eth_internet -j MASQUERADE

# Rejette tous les paquets des utilisateurs non authentifiés
$IPTABLES -t filter -A FORWARD -m mark --mark 99 -j DROP
