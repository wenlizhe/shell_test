#!/bin/bash
# 
# 服务器控制脚本
# ajianzheng
#
# Source function library.
#. /etc/rc.d/init.d/functions


function GetHost() {
    case $1 in 
        "4")
            echo "root@192.168.5.4"
            ;;
        "5")
            echo "root@192.168.5.5"
            ;;
        "6")
            echo "root@192.168.5.6"
            ;;
        "7")
            echo "root@192.168.5.7"
            ;;
        "8")
            echo "root@192.168.5.8"
            ;;
    esac
}

VALID_HOSTS="4 5 6 7 8"
