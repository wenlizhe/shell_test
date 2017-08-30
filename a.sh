#！/bin/bash

success_num=0
fail_num=0
s=0

function read_file(){
    for line in `cat 1.txt`
    do
        if [ `echo $line | grep -E "10[0-9]{6}"` ];then
            # ./killall.sh $1
            echo "meeting id" $line >2.txt
            # flag=1
            return 1
        fi
    done
    return 0
}

function do_work() {
    read_file
    if [ $? -eq 1 ];then
        echo 'success create meeting'
        success_num=`expr $success_num + 1`
    else
        echo 'fail create meeting'
        fail_num=`expr $fail_num + 1`
    fi
}


starttime=`date +"%Y-%m-%d %H:%M:%S"`

sys_time=`date -d "$starttime" +%s`

# todo main

# ./create.sh $1 $2| tee 1.txt| ./killall.sh $1
./create.sh $1 $2| tee 1.txt| ./killall.sh $1
do_work

endtime=`date +"%Y-%m-%d %H:%M:%S"`
in_data=`date -d "$endtime" +%s`

interval=`expr $in_data - $sys_time - 2 `


echo 'starttime' $sys_time
echo 'endtime' $in_data
echo "Response Time" $interval
echo 'success' $success_num
echo 'fail' $fail_num

echo "" >1.txt
exit 0
