#! /bin/bash

starttime=`date`

# todo main
# for(i=0;i<set_num;i++);
# ./create.sh $1 $2| tee 1.txt| ./killall.sh $1
#./create.sh $1 $2| tee 1.txt| ./killall.sh $1
#do_work
function demo(){
    for((i=0;i<5;i++))
    do
    {
#        ./create.sh 4
#        ./create.sh 5
#        ./create.sh 6
#        ./create.sh 7
#        ./create.sh 8
        ./hello.sh
    } &
    done
    wait
}

for((n=1;n<5;n++))
do
    sleep 1
    demo
done

echo 'starttime' ${starttime}
echo 'endtime' `date`

exit 0
