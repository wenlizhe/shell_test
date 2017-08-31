#!/bin/bash

flag=0
for((i=0;i<5;i++))
do
{
#    echo "hello world" $flag
    flag=`expr ${flag} + 1`
    echo "hello world" $flag
}
done



