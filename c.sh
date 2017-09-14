#!/bin/bash

success_num=0   # 成功次数
fail_num=0      # 失败次数
n=10            # 执行次数
ClientPerRoom=2 # 每个会议加入人数
MeetingNum=4    # 测试服务器编号

# 判断会议是否创建成功
function read_file_create(){
    for line in `cat $1`
    do
        if [ `echo ${line} | grep -E "10[0-9]{6}"` ];then
#        if [ `echo ${line} | grep -E "[0-9]{5}"` ];then
            echo "meeting id" ${line} >>./text/create.txt
            echo "meeting id" ${line}
            # todo 脚本加入会议成员会自动退一个，不知什么原因，暂时每次多加一个成员
            ./join.sh ${ClientPerRoom} ${line} ${MeetingNum} |tee ./text/join.txt |sleep 2 |exit
            for line in `cat ./text/join.txt`
            do
                if [ `echo ${line} | grep -E "MtcConfJoinOkNotification"` ];then
                    echo  ${line} >>./text/success.txt
                    return 1
                fi
            done
            return 0
#            ./join.sh ${ClientPerRoom} ${line} ${MeetingNum}
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

#function count_result(){
#    i=0
#    j=0
##    for line in `cat ./text/fail.txt`
##    do
##        if [ `echo ${line} | grep -E "fail"` ];then
##            i=`expr ${i} + 1`
##        fi
##    done
##    for line in `cat ./text/success.txt`
##    do
##        if [ `echo ${line} | grep -E "success"` ];then
##            j=`expr ${j} + 1`
##        fi
##    done
#
#    for line in `cat ./text/join.txt`
#    do
#        if [ `echo ${line} | grep -E "MtcConfJoinOkNotification"` ];then
#            j=`expr ${j} + 1`
#        else
#            i=`expr ${i} + 1`
#        fi
#    done
##    echo "success:"${j}
##    echo "fail:"${i}
#    return 0
#}

# 判断流程是否成功
function do_work() {
    read_file_create $1
#    read_file_join ./text/join.txt
    if [ $? -eq 1 ];then
        success_num=`expr ${success_num} + 1`
#        echo 'success create meeting' ${success_num}
#        echo 'success' >>./text/success.txt
    else
        fail_num=`expr ${fail_num} + 1`
#        echo 'fail create meeting' ${fail_num}
#        echo 'fail' >>./text/fail.txt
    fi
}

echo "" | tee ./text/1.txt ./text/2.txt ./text/3.txt ./text/4.txt ./text/5.txt ./text/create.txt ./text/join.txt \
./text/success.txt ./text/fail.txt
start_time=`date`                  # 定义脚本运行的开始时间

# todo main function
for((i=0;i<n;i++))
do
        sleep 1
        ./hello.sh| tee ./text/1.txt &&do_work ./text/1.txt
#        ./hello.sh| tee ./text/2.txt &&do_work ./text/2.txt
#        ./create.sh 4 |tee ./text/1.txt |sleep 2 |exit && do_work ./text/1.txt
done


stop_time=`date`                   # 定义脚本运行的结束时间
#count_result
echo 'success_num:'${success_num}
echo 'fail_num:'${fail_num}

#echo "TIME:`expr $stop_time - $start_time`"
echo ${start_time}
echo ${stop_time}
