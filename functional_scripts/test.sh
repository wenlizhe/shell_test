#!/bin/bash


# 判断一文件是不是字符设备文件，如果是将其拷贝到 /dev 目录下
function test1(){
    FILENAME=""
    echo "Input file name"
    read FILENAME
    if [ -c "$FILENAME" ]
    then
    cp $FILENAME /dev
    fi
}



function main(){
    test1
}

main
