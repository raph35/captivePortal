#!/bin/bash

# This script will set the connection between the access point and
# the firewall

# Verify if not root
if [ "$USER" != "root" ]; then
    echo "You must be root to execute the script"
    exit 1
fi
getIp(){
    ip -f inet -o addr show $1 | cut -d\  -f7 | cut -d/ -f1
}
ap (){
    # This function will configure the access point
    echo -n "Setting accesspoint ..."
    if [[ -z $ap_ip_fw ]] || [[ -z $ap_if_ap ]] || [[ -z $ap_if_fw ]]; then
        echo "Configuration invalid"
        exit 1
    fi
    if [ -z $ap_ip_ap ]; then
        ap_ip_ap=`getIp $ap_if_ap`
        if [ -z $ap_ip_ap ]; then
            echo 'Hotspot not working'
            exit 1
        fi
    fi

    # Setting the ip addr of the interface connected to the firewall
    /bin/ip addr add $ap_ip_fw/24 dev $ap_if_fw

    # Setting the gateway of the accesspoint
    route add default gw $fw_ip_ap
    echo "[OK]"
}

firewall (){
    # This function will configure the firewall
    echo "Setting firewall"
    # Setting the ip addr of the interface connected to the firewall
    /bin/ip addr add $fw_ip_ap/24 dev $fw_if_ap

    # Activate the forwarding
    echo 1 >/proc/sys/net/ipv4/ip_forward
}

reset (){
    # 
    echo "Resetting the config"
    
}

usage (){
    echo "Usage of $0: $0 {ap|fw|r}"
}

if [ $# -eq 1 ]; then
    # Sourcing the config file
    . conf/network.conf
    case $1 in
        ap)
            ap
            ;;

        fw)
            firewall
            ;;

        r)
            reset
            ;;

        *)
            usage
            ;;
    esac
else
    usage
fi