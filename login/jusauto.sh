#!/usr/bin/expect  
set timeout 7 
spawn ssh root@192.168.19.181
expect "*password*"
send "juphoon\r"
interact

