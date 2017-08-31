#!/bin/bash

success_num=0
fail_num=0
thread_num=5
n=5

function read_file(){
# todo(wlz) read file
    for line in `cat 1.txt`
    do
        if [ `echo ${line} | grep -E "10[0-9]{6}"` ];then
            echo "meeting id" ${line} >>2.txt
            return 1
        fi
    done
    return 0
}

function do_work() {
#   todo(wlz)count success/fail number have problem
    read_file
    if [ $? -eq 1 ];then
        success_num=`expr ${success_num} + 1`
        echo 'success create meeting' ${success_num}
        echo 'success' >>success.txt
    else
        fail_num=`expr ${fail_num} + 1`
        echo 'fail create meeting' ${fail_num}
        echo 'fail' >>fail.txt
    fi
}

echo "" >2.txt
start_time=`date`                  #定义脚本运行的开始时间
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，这时候文件描述符3就有了有名管道文件的所有特性
rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,所以这时候管道文件可以删除，我们留下文件描述符来用就可以了
for ((i=1;i<=thread_num;i++))               #控制进程数
do
        echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"
done

for ((i=1;i<=n;i++))
do
read -u3                           #代表从管道中读取一个令牌
{
#        ./create.sh 4 |tee 4.txt |exit |do_work
#        ./create.sh 4 |tee 4.txt |exit |do_work
#        ./create.sh 6 |tee 4.txt |exit |do_work
#        ./create.sh 7 |tee 4.txt |exit |do_work
#        ./create.sh 8 |tee 4.txt |exit |do_work
#       todo main function
        ./hello.sh ${i} && do_work
        ./hello.sh ${i} && do_work
        ./hello.sh ${i} && do_work
        ./hello.sh ${i} && do_work
        ./hello.sh ${i} && do_work
        echo 'success'${success_num}
        echo >&3                   #代表我这一次命令执行到最后，把令牌放回管道
}&
done
wait

stop_time=`date`                   #定义脚本运行的结束时间

#echo "TIME:`expr $stop_time - $start_time`"
echo ${start_time}
echo ${stop_time}
exec 3<&-                          #关闭文件描述符的读
exec 3>&-                          #关闭文件描述符的写
