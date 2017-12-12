#! /bin/bash
# 计算创建会议响应时间脚本
#
# Author: wenlizhe
# Last Changed:2017-9-28


t=5      # 运行时间，调试默认5s
num=5    # 每次并发进程数，根据自己服务器性能设置，要乘以服务器数量


# 计算运行时间差
function getTiming(){
    start=$1
    end=$2

    start_s=`echo ${start} | cut -d '.' -f 1`
    start_ns=`echo ${start} | cut -d '.' -f 2`
    end_s=`echo ${end} | cut -d '.' -f 1`
    end_ns=`echo ${end} | cut -d '.' -f 2`

    time_micro=$(( (10#$end_s-10#$start_s)*1000000 + (10#$end_ns/1000 - 10#$start_ns/1000) ))

    time_ms=`expr ${time_micro}/1000  | bc `
    sum=`expr ${t} \* ${num}`
    ave=`echo "scale=2; ${time_ms} / ${sum}" |bc`
    echo "Run Times: ${sum}"
    echo "Average Time: $ave ms"
    echo "Total Time: $time_ms ms"
    echo "$time_ms ms"
}


# 利用管道进行多线程控制，调用创建会议脚本
function main(){
    # 创建有名管道
    [ -e ./fd1 ] || mkfifo ./fd1
    # 创建文件描述符，以可读（<）可写（>）的方式关联管道文件，这时候文件描述符3就有了有名管道文件的所有特性
    exec 3<> ./fd1
    # 关联后的文件描述符拥有管道文件的所有特性,所以这时候管道文件可以删除，我们留下文件描述符来用就可以了
    rm -rf ./fd1
    # 创建令牌
    for i in `seq 1 2`;
    do
    # echo 每次输出一个换行符,也就是一个令牌
        echo >&3
    done
    # 拿出令牌，进行并发操作
    for((i=0;i<num;i++))
    do
        # read 命令每次读取一行，也就是拿到一个令牌
        read -u3
        {
            ./hello.sh
#            ./create.sh 4
#            ./create.sh 5
#            ./create.sh 6
#            ./create.sh 7
#            ./create.sh 8
#            sleep 1
            # 执行完一条命令会将令牌放回管道
            echo >&3
        }&
    done
    wait
    # 关闭文件描述符的读
    exec 3<&-
    # 关闭文件描述符的写
    exec 3>&-
}

#begin_time=`date +%s.%N`
for((j=0;j<t;j++))
do
#    demo >1.txt
    main
#    sleep 1
done
#end_time=`date +%s.%N`
#getTiming ${begin_time} ${end_time}
exit 0
