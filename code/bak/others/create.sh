#!/bin/bash

ENV='http:192.168.5.21:8080'


if [ -d log ]
then
    rm -rf log/*
else
    mkdir log
fi

PREFIX=`cat /dev/urandom | head -n 10 | md5sum | head -c 8`
create_meeting() {
    # USER=${PREFIX}"_"`printf "%06d" "0"`
    USER=`printf "%06d" "0"`;
    mkdir log/$USER
    count=0
    echo "cmd line:"$*

    ./ConfClient.exe -R $ENV $* -M 512 -f jsm.svc -d log/$USER $USER 2>&1 &

    while [ ! -e ./log/$USER/confNum.txt -o ! -s ./log/$USER/confNum.txt ]
    do
        echo "xxx"
        sleep 1
        count=`expr ${count} + 1`
        if [ ${count} -gt 15 ]
        then
            exit
        fi
    done
    MNO=`cat ./log/$USER/confNum.txt`
}

create_meeting $*

echo `date`
echo $MNO
