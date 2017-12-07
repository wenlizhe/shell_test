#!/usr/bin/expect  
set timeout 5 
spawn ssh root@123.207.71.29
expect "*password*"
send "Wlz1994105\r"
interact

