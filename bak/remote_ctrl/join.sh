#!/bin/bash
# 
# 服务器控制脚本
# ajianzheng
#
# Source function library.
#. /etc/rc.d/init.d/functions

source ./common.sh

SCRIPT_NAME=$0

function help() {
    echo -e "\033[32m""---------------------------------------------------------" "\033[0m"
    echo -e "\033[32m" "Usage: ${SCRIPT_NAME} <MEMBERS> <MNO> {all|4|5|6|7|8}" "\033[0m"
    echo -e "\033[32m""---------------------------------------------------------" "\033[0m"
    exit 1
}

if [ $# -le 2 ]; then help; fi

MEMBERS=$1
shift

MNO=$1
shift

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
    ssh -t -f $STR_HOST "export JsmDisableDecoderRender=true; cd confclient;./join.sh $MEMBERS $MNO; exit"
done

echo -e "\033[32m" "-=done!=-" "\033[0m"
