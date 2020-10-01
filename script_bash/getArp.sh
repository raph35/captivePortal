#!/bin/bash

#This script will show the mac adress of the interface
#passed in argument
if [ $# -eq 1 ]
then
    ip addr show $1 | grep ether | cut -d\  -f 6
else
    echo "Mauvais argument... entrer le nom de l'interface"
fi
