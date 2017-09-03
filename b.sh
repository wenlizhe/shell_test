#!/bin/bash

Njob=20    # 作业数目
Nproc=5    # 可同时运行的最大作业数

function read_file(){
# todo(wlz): read file has big peoblem!!!!!!
    for line in `cat $1`
    do
#        if [ `echo ${line} | grep -E "10[0-9]{6}"` ];then
        if [ `echo ${line} | grep -E "[0-9]{5}"` ];then
            echo "meeting id" ${line} >>./text/7.txt
#            echo $1
            return 1
        fi
    done
    return 0
}

function count_result(){
    i=0
    j=0
    for line in `cat ./text/fail.txt`
    do
        if [ `echo ${line} | grep -E "fail"` ];then
            i=`expr ${i} + 1`
        fi
    done
    for line in `cat ./text/success.txt`
    do
        if [ `echo ${line} | grep -E "success"` ];then
            j=`expr ${j} + 1`
        fi
    done
    echo "success:"${j}
    echo "fail:"${i}
    return 0
}

function do_work() {
    read_file $1
    if [ $? -eq 1 ];then
        success_num=`expr ${success_num} + 1`
#        echo 'success create meeting' ${success_num}
        echo 'success' >>./text/success.txt
    else
        fail_num=`expr ${fail_num} + 1`
#        echo 'fail create meeting' ${fail_num}
        echo 'fail' >>./text/fail.txt
    fi
}

function CMD {        # 测试命令, 随机等待几秒钟
#	n=$((RANDOM % 5 + 1))
#	echo "Job $1 Ijob $2 sleeping for $n seconds ..."
#	sleep $n
#	echo "Job $1 Ijob $2 exiting ..."
    ./hello.sh |tee ./text/1.txt && do_work ./text/1.txt
}
function PushQue {    # 将PID压入队列
	Que="$Que $1"
	Nrun=$(($Nrun+1))
}
function GenQue {     # 更新队列
	OldQue=$Que
	Que=""; Nrun=0
	for PID in $OldQue; do
		if [[ -d /proc/$PID ]]; then
			PushQue $PID
		fi
	done
}
function ChkQue {     # 检查队列
	OldQue=$Que
	for PID in $OldQue; do
		if [[ ! -d /proc/$PID ]] ; then
			GenQue; break
		fi
	done
}
echo "" | tee ./text/1.txt ./text/2.txt ./text/3.txt ./text/4.txt ./text/5.txt ./text/7.txt ./text/success.txt ./text/fail.txt
start_time=`date`                  #定义脚本运行的开始时间
for((i=1; i<=$Njob; i++)); do
	CMD $i &
	PID=$!
	PushQue $PID
	while [[ $Nrun -ge $Nproc ]]; do
		ChkQue
		sleep 1
	done
done
wait


count_result
stop_time=`date`                   #定义脚本运行的结束时间

#echo "TIME:`expr $stop_time - $start_time`"
echo ${start_time}
echo ${stop_time}