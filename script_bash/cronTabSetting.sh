#!/bin/bash

# CONF_PATH=/etc/captiveportal
CONF_PATH=conf
LIB_PATH=/usr/local/lib/captiveportal
CRONTAB_PATH=/tmp

if [ ! -f ${CONF_PATH}/captiveportal.conf ]
then
    echo "Missing configuration file"
    exit -1
fi
 . ${CONF_PATH}/captiveportal.conf
init(){

}

stop(){

}

usage(){
    echo $0 {init|stop|usage}
}

case $1 in
    init)
        init
        ;;

    stop)
        stop
        ;;

    *)
        usage