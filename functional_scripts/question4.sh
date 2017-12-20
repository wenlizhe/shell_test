#!/bin/bash


# 批量创建10个系统帐号oldboy01-oldboy10并设置密码（密码为随机8位字符串）

username='oldboy'
passwd=`cat /dev/urandom | head -n 10 | md5sum | head -c 8`
user_num=4


function create_user() {
    i=1
    while((i<$user_num))
    do
        echo `useradd $username$i -p passwd`
        i=$(($i+1))
    done
}

function del_user() {
    i=1
    while((i<$user_num))
    do
        echo `userdel -r $username$i`
        rm -rf /home/$username$i
        i=$(($i+1))
    done

}

function main(){
#    create_user
    echo $passwd
}

main
