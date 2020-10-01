#!/bin/bash

####Ajouter un utilisateur dans la liste des connectee
#dans le fichier /home/raph35/user et /home/raph35/macuser

#Configuration
path=/home/raph35/
path_file=$path'macUser'
#temps de validite en heure
vth=0
vtm=0
vts=40
if [ $# -eq 2 ]
then
    time=`date +%s`
    let "valid_time=3600*$vth + 60*$vtm + $vts"
    let "time_int = $time"
    let "expir_time = $time_int + $valid_time"
    echo $1/$2/$expir_time/$time_int/ >>$path_file
    echo "Ecriture dans le fichier terminée"
    /sbin/iptables -t mangle -I internet -m mac --mac-source $2 -j RETURN
    echo "Exclusion de $1 in $2 terminée"
else
    echo "Nombre d'argument invalide"
fi