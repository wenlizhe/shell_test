#! /bin/bash

success_num=0
fail_num=0
n=10
client_num=4
people_num=2

function read_file(){
    for line in `cat 1.txt`
    do
        if [ `echo $line | grep -E "MtcConfJoinOkNotification"` ];then
            echo  ${line} >>./text/meet.txt
            ./join.sh people_num ${line} client_num
            return 1
        fi
    done
    return 0
}

function count_result(){
    i=0
    j=0
#    for line in `cat ./text/fail.txt`
#    do
#        if [ `echo ${line} | grep -E "fail"` ];then
#            i=`expr ${i} + 1`
#        fi
#    done
    for line in `cat ./text/meet.txt`
    do
        if [ `echo ${line} | grep -E "MtcConfJoinOkNotification"` ];then
            j=`expr ${j} + 1`
        else
            i=`expr ${i} + 1`
        fi
    done
    echo "success:"${j}
    echo "fail:"${i}
    return 0
}


function do_work() {
    read_file
    if [ $? -eq 1 ];then
        echo 'success create meeting'
#        success_num=`expr $success_num + 1`
        echo 'success' >>./text/success.txt
    else
        echo 'fail create meeting'
#        fail_num=`expr $fail_num + 1`
        echo 'fail' >>./text/fail.txt
    fi
}


starttime=`date`

#sys_time=`date -d "$starttime" +%s`
#[ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
#exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，这时候文件描述符3就有了有名管道文件的所有特性
#rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,所以这时候管道文件可以删除，我们留下文件描述符来用就可以了
#for ((i=1;i<=thread_num;i++))      #控制进程数
#do
#    echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"
#done
#
#for ((i=1;i<=n;i++))
#do
#read -u3                           #代表从管道中读取一个令牌
#{
#

##        ./create.sh 4 |tee ./text/1.txt |sleep 2 |exit && do_work ./text/1.txt
##        ./create.sh 5 |tee ./text/2.txt |sleep 2 |exit && do_work ./text/2.txt
##        ./create.sh 6 |tee ./text/3.txt |sleep 2 |exit && do_work ./text/3.txt
##        ./create.sh 7 |tee ./text/4.txt |sleep 2 |exit && do_work ./text/4.txt
##        ./create.sh 8 |tee ./text/5.txt |sleep 2 |exit && do_work ./text/5.txt
#for((i=0;i<2;i++))
#do
#        sleep 1
#        ./hello.sh |tee ./text/1.txt && do_work ./text/1.txt
#
##        ./hello.sh |tee ./text/2.txt && do_work ./text/2.txt
##        ./hello.sh |tee ./text/3.txt && do_work ./text/3.txt
##        ./hello.sh |tee ./text/4.txt && do_work ./text/4.txt
##        ./hello.sh |tee ./text/5.txt && do_work ./text/5.txt
##        echo 'success'${success_num}
#        echo >&3                   #代表我这一次命令执行到最后，把令牌放回管道
#done
#}&
#done
#wait
# todo main
# for(i=0;i<set_num;i++);

for((i=0;i<n;i++))
do
 ./create.sh 4| tee 1.txt| sleep 2&& exit|do_work
#./hello.sh && do_work
done

#./create.sh $1 $2| tee 1.txt| ./killall.sh $1
#do_work
echo ${starttime}
endtime=`date`
echo ${endtime}
count_result
#in_data=`date -d "$endtime" +%s`

#interval=`expr $in_data - $sys_time - 2 `


#echo 'starttime' $sys_time
#echo 'endtime' $in_data
#echo "Response Time" $interval
#echo 'success' $success_num
#echo 'fail' $fail_num

echo "" >1.txt ./text/success.txt ./text/fail.txt ./text/meet.txt
exit 0

