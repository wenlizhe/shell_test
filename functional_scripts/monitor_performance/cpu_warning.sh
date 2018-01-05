#!/usr/bin/env bash
# 监控系统cpu的情况脚本程序

# 获取centos系统版本
version=`cat /etc/centos-release|sed -r 's/.* ([0-9]+)\..*/\1/'`

# 取当前空闲cpu百份比值（只取整数部分）
if [ $version -eq 6 ]
then
    IP=`ifconfig eth0| grep "inet addr"|cut -f 2 -d ":"|cut -f 1 -d " "`
    cpu_idle=`top -b -n 1|grep Cpu|awk '{print $5}'|cut -f 1 -d "."`
elif [ $version -eq 7 ]
then
    IP=`ifconfig eth0| grep "inet"|awk '{print $2}'`
    cpu_idle=`top -b -n 1|grep Cpu|awk '{print $8}'`
fi
echo $cpu_idle

# 设置空闲cpu的告警值为10%，如果当前cpu使用超过90%（即剩余小于10%），立即发邮件告警
if [ $cpu_idle -le 10 ]
then
    echo "${IP}服务器cpu剩余${cpu_idle}%，可能被挖矿，请及时处理。"| mail -s "cpu warming bash script" 489267629@qq.com
fi
