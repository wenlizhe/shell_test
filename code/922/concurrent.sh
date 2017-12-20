#! /bin/bash
# 并发创建会议脚本
#
# Author: wenlizhe
# Last Changed:2017-9-28


t=5      # 运行时间，调试默认5s
num=5    # 每次并发进程数，根据自己服务器性能设置，要乘以服务器数量


# 利用管道进行多线程控制，调用创建会议脚本
function main(){
    [ -e ./fd1 ] || mkfifo ./fd1
    exec 3<> ./fd1
    rm -rf ./fd1
    for i in `seq 1 2`;
    do
        echo >&3
    done
    for((i=0;i<num;i++))
    do
        read -u3
        {
            ./create.sh 4
#            ./create.sh 5
#            ./create.sh 6
#            ./create.sh 7
#            ./create.sh 8
            echo >&3
        }&
    done
    wait
    exec 3<&-
    exec 3>&-
}

for((j=0;j<t;j++))
do
    main >1.txt
    sleep 1
done

exit 0
