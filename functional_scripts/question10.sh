#!/usr/bin/env bash
# 循环打印下面这句话中字母数不大于6的单词(昆仑万维面试题)。
# I am oldboy teacher welcome to oldboy training class.


a='I am oldboy teacher welcome to oldboy training class.'

for i in $a
do
    #Usage1
#    num=`echo $i| wc -L`
    #Usage2
    num=${#i}
    if [ $num -le 6 ]
    then
        echo $i
    fi

done