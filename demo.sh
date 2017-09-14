#! /bin/bash

function read_file_create(){
    i=0
    for line in `cat 1.txt`
    do
        if [ `echo ${line} | grep -E "10[0-9]{6}"` ];then
#        if [ `echo ${line} | grep -E "[0-9]{5}"` ];then
            echo "meeting id" ${line} >>./text/create.txt
#            echo "meeting id" ${line}
            i=`expr ${i} + 1`

#            ./join.sh ${ClientPerRoom} ${line} ${MeetingNum}
#            return 1
        fi
    done
    return 0
}
read_file_create
echo $i
#starttime=`date`
#
## todo main
## for(i=0;i<set_num;i++);
## ./create.sh $1 $2| tee 1.txt| ./killall.sh $1
##./create.sh $1 $2| tee 1.txt| ./killall.sh $1
##do_work
#function demo(){
#    for((i=0;i<5;i++))
#    do
#    {
##        ./create.sh 4
##        ./create.sh 5
##        ./create.sh 6
##        ./create.sh 7
##        ./create.sh 8
#        ./hello.sh
#    } &
#    done
#    wait
#}
#
#for((n=1;n<5;n++))
#do
#    sleep 1
#    demo
#done
#
#echo 'starttime' ${starttime}
#echo 'endtime' `date`
#
#exit 0
