#!/bin/bash


success_num=0    # 成功次数
fail_num=0       # 失败次数
n=5              # 执行次数
ClientPerRoom=2 # 每个会议加入人数
MeetingNum=$1    # 测试服务器编号

# 判断会议是否创建成功
function read_file_create(){
    for line in `cat $1`
    do
        if [ `echo ${line} | grep -E "10[0-9]{6}"` ];then
#        if [ `echo ${line} | grep -E "[0-9]{5}"` ];then
            echo "meeting id" ${line} >>./text/create.txt
#            echo "meeting id" ${line}
            # todo (wlz 17-9-15):脚本控制加入人数会少一个，创建会议的成员会退出，脚本问题
#            ./join.sh ${ClientPerRoom} ${line} ${MeetingNum}> ./text/join.txt |sleep 2 |exit
            return 1
        fi

    done
    return 0
}

# 判断加入会议是否成功
#function read_file_join(){
#    for line in `cat $1`
#        do
#            if [ `echo ${line} | grep -E "MtcConfJoinOkNotification"` ];then
#                echo  ${line} >>./text/success.txt
#                return 1
#            fi
#        done
#    return 0
#}

# 判断流程是否成功
function do_work() {
    read_file_create $1
#    read_file_join ./text/join.txt
    if [ $? -eq 1 ];then
        success_num=`expr ${success_num} + 1`
    else
        fail_num=`expr ${fail_num} + 1`
    fi
}

#echo "" | tee ./text/1.txt  ./text/create.txt ./text/join.txt ./text/success.txt ./text/fail.txt

start_time=`date`                  # 定义脚本运行的开始时间

# todo ：main function
for((i=0;i<n;i++))
do
#        sleep 1
#        ./hello.sh| tee ./text/1.txt &&do_work ./text/1.txt
        ./create.sh ${MeetingNum} |tee ./text/1.txt |sleep 2 |exit && do_work ./text/1.txt
done

stop_time=`date`                   # 定义脚本运行的结束时间
#count_result
#echo 'success_num:'${success_num}
#echo 'fail_num:'${fail_num}

#echo "TIME:`expr $stop_time - $start_time`"
echo ${start_time}
echo ${stop_time}
