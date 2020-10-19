#!/bin/bash

# This script will analyse all iptables rules
# that are running on the firewall

all() {
    filter
    nat
    mangle
}

nat() {
    echo "Analysing NAT tables"
}

mangle() {
    echo "Analysing MANGLE tables"
}

filter() {
    echo "Analysing FILTER tables"
}

usage() {
    echo "Usage of the script"
    echo "$0 [nat|mangle|filter]"

}

if [ $# -gt 1 ]; then
    usage
    exit 0
fi

if [ $# -eq 1 ]; then
    case $1 in
    nat)
        nat
        ;;

    mangle)
        mangle
        ;;

    filter)
        filter
        ;;

    *)
        echo "Unkown option $1 - Try $0 usage for some help"
        ;;
    esac
else
    all
fi

