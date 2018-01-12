#!/usr/bin/env bash

# 使用uptime命令监控linux系统负载变化

# 获取centos系统版本
version=`cat /etc/centos-release|sed -r 's/.* ([0-9]+)\..*/\1/'`

if [ $version -eq 6 ]
then
    IP=`ifconfig eth0| grep "inet addr"|cut -f 2 -d ":"|cut -f 1 -d " "`
    cpu_idle=`top -b -n 1|grep Cpu|awk '{print $5}'|cut -f 1 -d "."`
elif [ $version -eq 7 ]
then
    IP=`ifconfig eth0| grep "inet"|awk '{print $2}'`
    cpu_idle=`top -b -n 1|grep Cpu|awk '{print $8}'`
fi

#抓取cpu的总核数
cpu_num=`grep -c 'model name' /proc/cpuinfo`

#抓取当前系统15分钟的平均负载值
load_15=`uptime | awk '{print $NF}'`


