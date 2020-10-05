#!/bin/sh

#	cron.2h.sh		Periodicaly script that will update
# the database and the firewall rules

# Sourcing functions that will be used in the script
if [ ! -f function.sh ]; then
	echo "File not found"
fi
. ./function.sh

# Launching the function that will update informations
updateConnected