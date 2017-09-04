#！/bin/bash

starttime=`date`
function read_file(){
# todo(wlz): read file has big peoblem!!!!!!
    for line in `cat 1.txt`
    do
#        if [ `echo ${line} | grep -E "10[0-9]{6}"` ];then
        if [ `echo ${line} | grep -E "MtcConfJoinOkNotification"` ];then
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
    read_file
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
# todo main
# for(i=0;i<set_num;i++);
# ./create.sh $1 $2| tee 1.txt| ./killall.sh $1
#./create.sh $1 $2| tee 1.txt| ./killall.sh $1
#do_work
for((i=0;i<50;i++))
do
{
    ./create.sh 4 | sleep 2| exit&&do_work
} &
done
wait

echo 'starttime' ${starttime}
echo 'endtime' `date`
count_result

echo "" >1.txt
exit 0
