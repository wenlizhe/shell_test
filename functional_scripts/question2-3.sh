#!/bin/bash

WORK_DIR=../test_dir/
# 随机字符串
#prefix=`cat /dev/urandom | tr -dc 'a-z' | head -c 10`

#使用for循环在/oldboy目录下通过随机小写10个字母加固定字符串oldboy批量创建10个html文件
function create_file(){
    i=1
    while (($i<11))
    do
#        cd ${WORK_DIR} && touch `tr -dc "a-z"</dev/urandom |head -c 10`_test.html
        cd ${WORK_DIR} && touch `cat /dev/urandom | tr -dc 'a-z' | head -c 10`_oldboy.html
        i=$(($i+1))
    done
}


# 将以上文件名中的oldboy全部改成oldgirl(用for循环实现),并且html改成大写
function change_case_method1(){
    change_name='_oldgirl.HTML'
    file=`ls ../test_dir/`
    for i in $file
    do
        c=`echo $i | cut -c 1-10`
        mv $WORK_DIR/$c* $WORK_DIR/$c$change_name
    done
}


function change_case_method2(){
    change_name='_oldgirl.HTML'
    file=`ls ../test_dir/`
    for i in $file
    do
        c=`echo $i | awk -F '_' '{print $1}'`
        mv $WORK_DIR/$c* $WORK_DIR/$c$change_name
    done

}
function main(){
    if [ -d ${WORK_DIR} ];
    then
        create_file
    else
        mkdir $WORK_DIR
        create_file
    fi
}


# main
change_case_method2
