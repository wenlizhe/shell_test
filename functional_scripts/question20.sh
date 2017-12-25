#!/bin/sh

sed -i 's/\,\ | \.//g' /Users/wen/Documents/github/shell_test/test_dir/test.txt

for i in `cat  /Users/wen/Documents/github/shell_test/test_dir/test.txt`
do 
    echo $i
done 
