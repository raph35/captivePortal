#!/bin/sh

#Ce script utilise la commande rarp pour determiner
#l'ip d'un mac donnee et puis fais un ping pour
#determiner si l'utilisateur est enconre connectee
path='/home/raph35/'
path_macAddr=$path'macUser'

while IFS=/ read name mac end_time begin_time
do
    ip=`rarp mac`;
    ping -w 1.5 $ip
    echo $name/$mac/$end_time/$begin_time >>$path_macAddr'.tmp'
    case $? in 
        0)
            echo "Ping successful"
            echo $name/$mac/$end_time/$begin_time >>$path_macAddr'.tmp'
            ;;
        1)
            echo "Erreur ping(hote innacessible)"
            ;;
        2)
            echo "Hote inconnue"
            ;;
        *)
            echo "Erreur inconnue"
            ;;
        done < $path_macAddr

# mv $path_macAddr'.tmp' $path_macAddr
