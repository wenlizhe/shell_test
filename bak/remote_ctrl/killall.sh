#!/bin/bash
# 
# 服务器控制脚本
# ajianzheng
#
# Source function library.
#. /etc/rc.d/init.d/functions

source ./common.sh

SCRIPT_NAME=$0
ALL_PARAM=0

function help() {
    echo "---------------------------------------------------------"
    echo -e "\033[32m" "Usage: ${SCRIPT_NAME} {all|4|5|6|7|8}" "\033[0m"
    echo "---------------------------------------------------------"
    exit 1
}

if [ $# -eq 0 ]; then help;

for host in $*
do
    case "${host}" in
        "4"|"5"|"6"|"7"|"8")
            HOSTS=${HOSTS}" "${host}
            ;;
        "all")
            ALL_PARAM=1
            ;;
        *)
            echo "INVALID HOST:" $host 
            help
            ;;
    esac
done

if [ $ALL_PARAM -eq 1 ]; then HOSTS=$VALID_HOSTS; fi

for host in $HOSTS
do
    echo -e "\033[32m""-- Host: $host ------------------" "\033[0m"
    STR_HOST=`GetHost $host`
    ssh -n $STR_HOST "cd confclient;./killall.sh; exit"
done

echo -e "\033[32m" "-=done!=-" "\033[0m"
