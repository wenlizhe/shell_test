#!/bin/sh

random=`cat /dev/random | tr -dc 'a-z 0-9' |head -c 10`
echo $random
