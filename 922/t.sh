#!/bin/bash

a=`grep -o -E 'MtcConfCreateOkNotification: [0-9]{8}' 1.txt |grep -o -E '[0-9]{8}'`

if [ `echo ${a} | grep -E "10[0-9]{6}"` ];then
    echo ${a}
    echo 'ok'

fi
