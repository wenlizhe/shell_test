#!/usr/bin/env bash

# 打印错误信息和其他状态信息
err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# 1、创建目录/data/oldboy ，并且在该目录下创建文件oldboy.txt，
# 然后在文件oldboy.txt里写入内容"inet addr:10.0.0.8 Bcast:10.0.0.255 Mask:255.255.255.0"（不包含引号）。
function test1(){
    str='inet addr:10.0.0.8 Bcast:10.0.0.255 Mask:255.255.255.0'
    if [ ! -d /test ]
    then
        mkdir /test
    fi
    echo $str >./test/test.txt
}

# 2.将题1中的oldboy.txt文件内容通过命令过滤只输出如下内容：
# 10.0.0.8 10.0.0.255  255.255.255.0
function test2(){
    echo `grep -Eo '\d+.\d+.\d+.\d+' ./test/test.txt`
}

# 3、将题1中的oldboy目录移动到/tmp目录下，并将/etc/passwd文件复制到/tmp/oldboy下。
function test3(){
    echo `mv /test /tmp | cp -a /etc/passwd /tmp/test/`
}

# 4、在题3的基础上使用awk取passwd文件的第10行到20行的第三列重定向到/tmp/oldboy/test.txt文件里。
function test4(){
    cat ./test/passwd| tail -n +10|head -n 10| awk '{print $3}' >> ./test/test.txt
    # echo $a
}

# 5、在题3的基础上要求用命令rm删除文件时提示如下禁止使用rm的提示，并使该效果永久生效。
function test5(){
    pass
}

# 6.在题3的基础上，删除/tmp/oldboy/下除passwd以外的其他文件
function test6(){
    cp ./test/passwd ../| rm -rf test/* |cp passwd ./test/

}

# 7、在题3的基础上，请打印/etc/passwd文件中的第2-5行（不低于三种方法
function test7(){
    cat ./test/passwd |tail -n +2|head -n 4
    cat ./test/passwd | awk 'NR<6'|awk 'NR>1'
    nl ./test/passwd | tail -n +2|head -n 4
}

# 8、在题3的基础上，使用命令调换passwd文件里root位置和/bin/bash位置？即将所有的第一列和最后一列位置调换
function test8(){
#   改变列
    awk -F ":" '{a=$1;$1=$NF;$NF=a;print}' ./test/test.txt|tr " " ":"
#   改变行
    l=`awk '{print NR}' ./test/test.txt|tail -n1`
    for(( i=1;i<=$l;i++ ));
    do
        case $i in
        1)
            sed -n ${l}p ./test/test.txt
            ;;
        $l)
            sed -n 1p ./test/test.txt
            ;;
        *)
            sed -n ${i}p ./test/test.txt
            ;;
        esac;
    done
}

# 9.把/opt/test/目录及其子目录下所有以扩展名.txt结尾的文件中包含oldgirl的字符串全部替换为oldboy
function test9(){
    DIR='/opt/test'
    test ! -d $DIR && echo -e "The $DIR is not exist in your system.\n" && exit 1
    # find_dir=`find $DIR -name "*.txt" | xargs grep "oldgirl" -l`
    # echo $find_dir
    find $DIR -name "*.txt"| xargs perl -pi -e 's|oldboy|oldgirl|g'
}

# 10、查找/oldboy下所有7天以前以log结尾的大于1M的文件移动/tmp下
function test10(){
    dir=`find $DIR -type f -name *.log -mtime +7 -size +1M`
    for i in $dir
    do
        mv $i /tmp
    done
}

# 请使用sed和awk写出一个批量更改文件名的命令，例如将rce开头文件修改为rbe开头文件

# 请写出一个删除当前及子目录中“.tmp”文件的命令

function main(){
    test9
}

main
