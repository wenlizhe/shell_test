#!/bin/bash

echo "1.[install lamp]"
echo "2.[install lnmp]"
echo "3.[exit]"

read -t 30 -p "pls input the num you want:" a

case $a in  
    1)  
        if  
            [ -f lamp.sh ];then  
                ./lamp.sh  
                sleep 3  
                echo "lamp is installed!"  
        else  
            echo "no lamp.sh!"  
        fi  
    ;;  
  
    2)  
        if  
            [ -f lnmp.sh ];then  
                ./lnmp.sh  
                sleep 3  
                echo "lnmp is installed!"  
        else  
            echo "no lnmp.sh!"  
        fi  
    ;;  
  
    3)  
        exit 0  
    ;;  
  
    *)  
        echo  "Input error"  
        exit 0  
esac

