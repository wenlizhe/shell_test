#!/bin/bash

ENV='http:192.168.5.9:8080'

if [ -d log ]
then
    rm -rf log/*
else
    mkdir log
fi
PREFIX=`cat /dev/urandom | head -n 10 | md5sum | head -c 8`
create_meeting() {
    count=0
    USER=${PREFIX}"_"`printf "%06d" "0"`
    PASSWORD="123456"
    mkdir log/$USER

    echo "cmd line:"$*

    ./ConfClient.exe -U $USER -P $PASSWORD -R $ENV $* -M 512 -f jsm.svc -d log/$USER $USER 2>&1 &

    while [ ! -e ./log/$USER/confNum.txt -o ! -s ./log/$USER/confNum.txt ]
    do
        count=`expr ${count} + 1`
        echo "xxx"
        sleep 1
        if [ ${count} -gt 10 ]
        then
            exit
        fi
    done
    MNO=`cat ./log/$USER/confNum.txt`
}

create_meeting $*

echo `date`
echo $MNO
