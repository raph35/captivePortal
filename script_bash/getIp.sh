#!/bin/bash

showip(){
    ip -f inet -o addr show $1 | cut -d\  -f 7 | cut -d/ -f 1
}

if [ $# == 0 ]; then
    #echo "Pas d'argument"
    ip=`showip wlp3s0`
    echo $ip
elif [ $# == 1 ]; then
    #echo "Argument 1"
    ip=`showip $1`
    echo $ip
else
    echo "Argument invalide"
fi
