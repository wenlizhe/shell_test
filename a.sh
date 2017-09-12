#！/bin/bash

success_num=0
fail_num=0
n=10

function read_file(){
    for line in `cat 1.txt`
    do
        if [ `echo ${line} | grep -E "MtcConfJoinOkNotification"` ];then
            # ./killall.sh $1
            echo  ${line} >>./text/meet.txt
            ./join.sh 3 ${line} 4
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

# todo main
# for(i=0;i<set_num;i++);

for((i=0;i<n;i++))
do
# ./create.sh | tee 1.txt| sleep 2 && exit
./hello.sh && do_work
done

#./create.sh $1 $2| tee 1.txt| ./killall.sh $1
#do_work
echo $starttime
endtime=`date`
echo $endtime
count_result
#in_data=`date -d "$endtime" +%s`

#interval=`expr $in_data - $sys_time - 2 `


#echo 'starttime' $sys_time
#echo 'endtime' $in_data
#echo "Response Time" $interval
#echo 'success' $success_num
#echo 'fail' $fail_num

echo "" >1.txt
exit 0
