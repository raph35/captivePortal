#!/bin/sh

ping -w 1.5 -c 1 $1 >/dev/null 2>&1
returnPing=$?

case $returnPing in
0)
    echo "Ping successful"
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
esac