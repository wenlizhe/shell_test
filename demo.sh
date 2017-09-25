#! /bin/bash


t=60     # 运行时间，默认60s
num=$1    # 并发次数，要乘以服务器数量

# todo main

function demo(){
    for((i=0;i<num;i++))
    do
   {
        ./create.sh 4
        ./create.sh 5
        ./create.sh 6
        ./create.sh 7
#        ./create.sh 8
        sleep 1
    } &
    done
    wait
}

# 计算运行时间差
function getTiming(){
    start=$1
    end=$2

    start_s=`echo ${start} | cut -d '.' -f 1`
    start_ns=`echo ${start} | cut -d '.' -f 2`
    end_s=`echo ${end} | cut -d '.' -f 1`
    end_ns=`echo ${end} | cut -d '.' -f 2`

    time_micro=$(( (10#$end_s-10#$start_s)*1000000 + (10#$end_ns/1000 - 10#$start_ns/1000) ))
    time_ms=`expr ${time_micro}/1000  | bc `

    echo "$time_micro microseconds"
    echo "$time_ms ms"
}


begin_time=`date +%s.%N`
for((n=0;n<t;n++))
do
#    sleep 1
    demo
done
end_time=`date +%s.%N`

getTiming ${begin_time} ${end_time}
exit 0
