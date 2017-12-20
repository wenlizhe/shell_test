#!/bin/bash

#开发shell脚本分别实现以脚本传参以及read读入的方式比较2个整数大小。
# 以屏幕输出的方式提醒用户比较结果。注意：一共是开发2个脚本。当用脚本传参以及read读入的方式需要对变量是否为数字、并且传参个数做判断
sum=$#
p=$*
# 判断变量类型
function check(){
    local a="$1"
#    printf "%d" "$a" &>/dev/null && echo 1 && return
#    printf "%d" "$(echo $a|sed 's/^[+-]\?0\+//')" &>/dev/null && echo 2 && return
#    printf "%f" "$a" &>/dev/null && echo 3 && return
    if echo $1 | egrep -q '^[0-9]+$'; then
        echo 1
    else
        echo 2
    fi
}

function compare(){
    if [ $1 -gt $2 ]
    then
        echo "$1 is greater then $2"
        exit 0
    elif [ $1 -lt $2 ]
    then
        echo "$2 is greater then $1"
        exit 0
    else
        echo "$2 is equal with $1"
        exit 0
    fi
}

function judgment_transfer() {
    if [ $# -gt 2 ]
    then
        echo "error, too much parameter!"
        exit 1
    elif [ $# -lt 2 ]
    then
        echo "error, parameter less then 2!"
        exit 0
    fi
    for i in $*
    do
        case $(check "$i") in
            1)
            ;;

            2)  echo "$i is not integer"
                exit 1
            ;;
        esac
    done
    compare $p
}

#todo 171220
function judgment_read() {
    read -p "input Numbers: " n1 n2 n3
    if [ -z $n1 ]
    then
        echo "you must input two number"
        exit 1
    fi
    if [ -z $n2 ]
    then
        echo "you must input two number"
        exit 1
    fi
    if [ -z $n3 ]
    then
        echo $n2

        for i in $n1, $n2
        do
            echo $n2
            case $(check "$i") in
            1)
            ;;

            2)  echo "$i is not integer"
                exit 1
            ;;
            esac
        done

    else
        echo "you must just input two number"
    fi
    compare $n1 $n2
}

function main(){
#    judgment_transfer $p
    judgment_read
}

#main

judgment_read
