#! /bin/bash

n=10             # 执行次数
MeetingNum=$1    # 测试服务器编号


function read_create_log(){
    a=`grep -o -E 'MtcConfCreateOkNotification: [0-9]{8}' $1 |grep -o -E '[0-9]{8}'`
    if [ `echo ${a} | grep -E "[0-9]{8}"` ];then
#        if [ `echo ${line} | grep -E "[0-9].*"` ];then
        echo ${a} >>create.log
        return 1
    fi
    return 0
}

# 统计创建成功率
function count_create_result(){
    success_num=0    # 成功次数
    fail_num=0       # 失败次数
    for line in `cat create.log`
    do
        if [ `echo ${line} | grep -E "[0-9]{5}"` ];then
            success_num=`expr ${success_num} + 1`
        fi
    done
    fail_num=`expr ${n} - ${success_num}`
#    sum=`expr ${success_num} + ${fail_num}`
    echo "Success:"${success_num}
    echo "Fail:"${fail_num}
#    echo 'Success Rate:' `awk 'BEGIN{printf "%.2f%\n",(`${success_num}`/`${sum}`)*100}'`
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

#    echo "$time_micro microseconds"
    echo "$time_ms ms"
}


function do_work(){

    for((i=0;i<n;i++))
    do
        #begin_time=`date +%s.%N`
#        ./create.sh MeetingNum |tee 1.txt |sleep 2 |exit && read_create_log 1.txt
        ../../922/hello.sh |tee 1.txt &&read_create_log 1.txt
        #end_time=`date +%s.%N`
        #getTiming ${begin_time} ${end_time}
    done

}

# main
echo "" | tee 1.txt create.log
#begin_time=`date +%s.%N`
do_work
#end_time=`date +%s.%N`
count_create_result
#getTiming ${begin_time} ${end_time}
exit 0
