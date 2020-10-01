#!/bin/bash

path='/home/raph35'
path_macAddr=$path'/macUser'
path_newMacAddr=$path'/newUser'
#Mise a jour des listes des mac(supression ds mac expires)

/bin/bash flushuser.sh
echo 'User flushed'

mv $path_newMacAddr $path_macAddr
echo "Fichier $path_macAddr mis à jour"