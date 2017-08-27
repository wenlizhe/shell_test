#!/bin/bash



# for((i = 0; i < 60; i=(i+setp))); do
# {
#     echo `date`
#     sleep $step
# }
# done

# exit 0
# echo `date`
# for ((i=0;i<5;i++));do
# {
#     sleep 3;echo 1>>aa && echo ”done!”
# } &

# done
# wait
# echo `date`
# # cat aa|wc -l

# # rm aa
# exit 0

thread_num = 20
mkfifo tmp
mkfifo 9<>tmp

for((i=0;i<$thread_num;i++))
do
    echo -ne "\n"
