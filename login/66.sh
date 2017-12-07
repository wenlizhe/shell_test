#!/usr/bin/expect  
set timeout 5 
spawn ssh root@192.168.0.66
expect "*password*"
send "juphoon419708\r"
interact
