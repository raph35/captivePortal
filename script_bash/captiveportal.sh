#!/bin/sh
#
# captiveportal			Startup script for the Captive Portal
#
# description: Captive portal is a system which redirect every client 
#	to an authentication page before accessing internet
# config: /etc/captiveportal/captiveportal.conf
RETVAL=0
SCRIPTNAME="${0##*/}"
IPTABLES=/sbin/iptables

# Function that display the usage of the script
usage() {
	echo "Usage: $SCRIPTNAME {start|stop|restart|reboot}\n"
}

# Test if the number of argument is correct
if [ $# -ne 1 ]; then
	usage
	exit 1
fi


# Source variables from configuration file.
if [ ! -f conf/captiveportal.conf ]; then
	echo -n "Missing configuration file.
       	`pwd`/conf/captiveportal.conf not found"
	exit 1
fi
. ./conf/captiveportal.conf

# Sourcing functions that will be used in the script
if [ ! -f function.sh ]; then
	echo "File not found"
fi
. ./function.sh

# Functions
start() {
	echo "Starting captive portal..."	
	$IPTABLES -N internet -t mangle
	# echo "Chaine internet créer"

	#Envoi tous les traffics vers la chaine internet
	$IPTABLES -t mangle -A PREROUTING -j internet

	$IPTABLES -t mangle -A internet -i $eth_internet -j RETURN
	$IPTABLES -t mangle -A internet -i lo -j RETURN
	$IPTABLES -t mangle -A internet -j MARK --set-mark 99

	# Redirection des requettes http des utilisateurs non autorisée vers la page de login
	$IPTABLES -t nat -A PREROUTING -m mark --mark 99 -p tcp --dport 80 -j DNAT --to-destination $ip_addrWeb
	$IPTABLES -t nat -A PREROUTING -m mark --mark 99 -p tcp --dport 443 -j DNAT --to-destination $ip_addrWeb

	# authorise les requettes dns servers
	$IPTABLES  -I FORWARD -p udp --dport 53 -j ACCEPT

	#Authorise la connection à l'internet
	echo "1" >/proc/sys/net/ipv4/ip_forward
	$IPTABLES -A FORWARD -i $eth_internet -o $eth_local -m state --state ESTABLISHED,RELATED -j ACCEPT
	$IPTABLES -A FORWARD -i $eth_local -o $eth_internet -j ACCEPT
	$IPTABLES -t nat -A POSTROUTING -o $eth_internet -j MASQUERADE

	# Rejette tous les paquets des utilisateurs non authentifiés
	$IPTABLES -t filter -A FORWARD -m mark --mark 99 -j DROP

	echo "Service captive portal launched		[OK]"
}

stop() {
	echo "Stopping captive portal..."
	$IPTABLES -t mangle -F
	$IPTABLES -t mangle -X
	$IPTABLES -t nat -F
	$IPTABLES -F
	$IPTABLES -X
	echo "Stopping service captive portal		[OK]"
}

addConnectedUser() {
	querySql 'SELECT pseudo, mac, ip FROM connected' | while read -r line
	do
		# echo $line
		mac=`echo "$line" | cut -f2`
		/sbin/iptables -t mangle -I internet -m mac --mac-source $mac -j RETURN
	done
}

# Main function
case "$1" in
	start)
		start
		addConnectedUser
		;;
	stop)
		stop
		;;
	restart)
		echo "Restarting service..."
		stop
		start
		addConnectedUser
		;;
	reboot)
		echo "Rebooting service..."
		stop
		start
		;;
	*)
		usage
		exit 1
esac

exit $RETVAL