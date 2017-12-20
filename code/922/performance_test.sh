#! /bin/bash
# 性能测试脚本
# 用于大量创建加入会议
# Author: wenlizhe
# Last Changed:2017-9-28


n=5              # 执行次数
ClientPerRoom=3 # 每个会议加入人数
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


function main(){
    ./create.sh ${MeetingNum} |tee ./text/1.txt |sleep 2 |exit && read_file_create ./text/1.txt
}


for((j=0;j<n;j++))
do
    main
done

exit 0
