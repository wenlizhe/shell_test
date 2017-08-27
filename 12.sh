#!/usr/bin/expect  
set timeout 5 
spawn ssh root@192.168.5.12  -p 30022
expect "*password*"
send "Yinshipin1234_\r"
interact

