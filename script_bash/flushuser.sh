#!/bin/bash

#Ce script met à jour le fichier contenant les utilisateurs
#connectés dans /var/lib/users
#configuration
path='/home/raph35/'
path_user=$path'user'
path_macAddr=$path'macUser'
path_newMacAddr=$path'newUser'

clearExpireMac(){
    #Ce fonction lit le fichier contenant
    #tous les utilisateurs connecte et supprime ce qui sont 
    #deja expire et cree un nouveau fichier contenant les utilisateurs
    #qui ne sont pas encore expire

    let "connected = 0"
    let "expired = 0"
    current_time=`date +%s`
    echo "Le current time is $current_time"
    let "cTime = $current_time"

    if [ -e $path_newMacAddr ]
    then
        rm $path_newMacAddr
    else
        touch $path_newMacAddr
    fi
    while IFS=/ read name mac end_time begin_time
    do
    let "eTime = $end_time"
    let "bTime = $begin_time"
    let "inter_time = $cTime - $bTime"
    let "remain_time = $eTime - $cTime"
    
    #Si l'utilisateurest encore connecte(son temps est encore valide)
    echo $cTime $eTime
    if [ $cTime -le $eTime ]
    then
        let 'connected++'
        echo "Le temps de connection de $name: $inter_time"
        echo "Le temps restant de $name: $remain_time"
        echo $name/$mac/$end_time/$begin_time >>$path_newMacAddr
    else
        let 'expired++'
        echo "Utilisateur expiré: $name"
    fi
    done < $path_macAddr
    echo "Stat:
    Connecté: $connected
    Expiré: $expired"
}

#readFile()}
clearExpireMac
