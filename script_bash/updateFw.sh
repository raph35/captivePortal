#!/bin/sh

#Ce script met a jour le parefeu en excluant les utilisateurs connectes
#qui sont listés dans le fichier /home/raph35/macUser

IPTABLES=/sbin/iptables
path_macAddr=/home/raph35/macUser

$IPTABLES -t mangle -D internet
echo "Chaine supprimée"

awk 'BEGIN { FS="/"; } { system("$IPTABLES -t mangle -A internet -m mac --mac-source "$2" -j RETURN"); }' $path_macAddr
echo "Mise a jour du pare-feu"