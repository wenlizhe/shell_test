#! /bin/bash
# 计算创建会议响应时间脚本
#
# Author: wenlizhe
# Last Changed:2017-9-28


t=5      # 运行时间，调试默认5s
num=5    # 每次并发进程数，根据自己服务器性能设置，要乘以服务器数量
success_num=0    # 成功次数
fail_num=0       # 失败次数
n=5              # 执行次数
ClientPerRoom=2 # 每个会议加入人数
MeetingNum=$1    # 测试服务器编号


# 判断会议是否创建成功
function read_file_create(){
    m=`grep -o -E 'MtcConfCreateOkNotification: [0-9]{8}' $1 |grep -o -E '[0-9]{8}'`
    if [ `echo ${m} | grep -E "10[0-9]{6}"` ];then
        echo "meeting id" ${m} >>./text/create.txt
        echo "meeting id" ${m}
        # todo (wlz 17-9-15):创建会议的shell被exit后创建会议的成员会退出，目前解决方案为多加入一个人
       ./join.sh ${ClientPerRoom} ${m} ${MeetingNum}> ./text/join.txt |sleep 2 |exit
        return 1
    fi
    return 0
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
    sum=`expr ${t} \* ${num}`
    ave=`echo "scale=2; ${time_ms} / ${sum}" |bc`
    echo "Run Times: ${sum}"
    echo "Average Time: $ave ms"
    echo "Total Time: $time_ms ms"
    echo "$time_ms ms"
}


# 判断流程是否成功
function do_work() {
    read_file_create $1
    if [ $? -eq 1 ];then
        success_num=`expr ${success_num} + 1`
    else
        fail_num=`expr ${fail_num} + 1`
    fi
}


# 利用管道进行多线程控制，调用创建会议脚本
function main(){
    for((i=0;i<n;i++))
    do
    #        sleep 1
    #        ./hello.sh| tee ./text/1.txt &&do_work ./text/1.txt
    ./create.sh ${MeetingNum} |tee ./text/1.txt |sleep 2 |exit && do_work ./text/1.txt
    done
}

#begin_time=`date +%s.%N`
for((j=0;j<t;j++))
do
#    demo >1.txt
    main
#    sleep 1
done
#end_time=`date +%s.%N`
#getTiming ${begin_time} ${end_time}
exit 0
