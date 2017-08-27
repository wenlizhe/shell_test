#!/usr/bin/expect  
set timeout 5 
spawn ssh root@119.23.63.91
expect "*password*"
send "Wlz1994105\r"
interact

