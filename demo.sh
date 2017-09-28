#! /bin/bash
# 并发创建会议脚本
#
# Author: wenlizhe
#
t=5      # 运行时间，调试默认5s
num=$1    # 并发次数，要乘以服务器数量


# todo(17-9-26)wlz:较为简陋，有空用管道实现
function demo(){
    for((i=0;i<num;i++))
    do
   {
        ./create.sh 4
       # ./create.sh 5
       # ./create.sh 6
       # ./create.sh 7
       # ./create.sh 8
     #   sleep 1
    } &
    done
    wait
}


# 利用管道进行多线程控制，调用创建会议脚本
function main(){
    [ -e ./fd1 ] || mkfifo ./fd1
    exec 3<> ./fd1
    rm -rf ./fd1
    for i in `seq 1 2`;
    do
        echo >&3
    done
    for((i=0;i<num;i++))
    do
        read -u3
        {
            ./hello.sh
#            ./create.sh 4
#            ./create.sh 5
#            ./create.sh 6
#            ./create.sh 7
#            ./create.sh 8
#            sleep 1
            echo >&3
        }&
    done
    wait
    exec 3<&-
    exec 3>&-
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

    echo "$time_ms ms"
}


begin_time=`date +%s.%N`
for((j=1;j<=t;j++))
do
 #   sleep 1
    demo >1.txt
done
end_time=`date +%s.%N`

getTiming ${begin_time} ${end_time}
exit 0
