#!/bin/bash
# 
# 服务器控制脚本
# ajianzheng
#
# Source function library.
#. /etc/rc.d/init.d/functions

source common.sh

SCRIPT_NAME=$0

function help() {
    echo "---------------------------------------------------------"
    echo -e "\033[32m" "Usage: ${SCRIPT_NAME} {4|5|6|7|8}" "\033[0m"
    echo "---------------------------------------------------------"
    exit 1
}

if [ $# -eq 0 ]; then help; fi

case $1 in
    "4"|"5"|"6"|"7"|"8")
        STR_HOST=`GetHost "$1"`
        ;;
    *)
        echo "INVALID HOST:" $host 
        help
        ;;
esac

shift

ssh -f $STR_HOST "export JsmDisableDecoderRender=true; cd confclient;./create.sh $*; exit"

echo -e "\033[32m" "-=done!=-" "\033[0m"


