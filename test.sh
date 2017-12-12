#!/bin/bash


function print_line_num(){
    l=`cat 1.txt |wc -l`
    l=`expr ${l} + 1`
    i=0
    cat 1.txt | while read line
    do
        i=`expr ${i} + 1`
        if [ ${i} == 10 ]
        then
           echo ${line}
        elif [ ${i} -gt 10 ]
        then
           echo "a 大于 b"
        elif [ ${i} -lt 10 ]
        then
           break
        else
           echo "没有符合的条件"
        fi
        echo ${line}
    done
#    while [ ${l} -ge 10 ]
#    do
#        pass
#    done


#    echo ${l}
}


function main(){
    print_line_num
}

# echo ''>1.txt
main
