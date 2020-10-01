#!/bin/sh

path_macAddr=/home/raph35/macUser
#awk 'BEGIN { FS="/"; } { system("$IPTABLES -t mangle -A internet -m mac --mac-source "$2" -j RETURN"); }' $path_macAddr
awk 'BEGIN { FS="/"; } { "echo $2"; }' $path_macAddr
while IFS=/ read name mac end_time begin_time
do
    echo "iptables -t mangle -A internet -m mac --mac-source $mac -j RETURN"
done < $path_macAddr