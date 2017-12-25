#!/usr/bin/env bash

str='inet addr:10.0.0.8 Bcast:10.0.0.255 Mask:255.255.255.0'

# 1、创建目录/data/oldboy ，并且在该目录下创建文件oldboy.txt，
# 然后在文件oldboy.txt里写入内容"inet addr:10.0.0.8 Bcast:10.0.0.255 Mask:255.255.255.0"（不包含引号）。
function test1(){
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

#7、在题3的基础上，请打印/etc/passwd文件中的第2-5行（不低于三种方法
function test7(){
    cat ./test/passwd |tail -n +2|head -n 4
    cat ./test/passwd | awk 'NR<6'|awk 'NR>1'
    nl ./test/passwd | tail -n +2|head -n 4
}

# 8、在题3的基础上，使用命令调换passwd文件里root位置和/bin/bash位置？即将所有的第一列和最后一列位置调换
function test8(){
#    a=`cat ./test/passwd |head -n 1`
#    b=`cat ./test/passwd |tail -n 1`
#    cat ./test/test.txt|sed '$d'| sed 1d
#    sed '1' $b -i ./test/test.txt
    c=`awk '{print NR}' ./test/test.txt|tail -n1`
    for(( i=1;i<=$c;i++ ));
    do
        case $i in
        1)
            sed -n ${c}p ./test/test.txt
            ;;
        $c)
            sed -n 1p ./test/test.txt
            ;;
        *)
            sed -n ${i}p ./test/test.txt
            ;;
        esac;
    done
}
function main(){
    test8
}

main
