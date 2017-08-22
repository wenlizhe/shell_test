#!/usr/bin/expect  
set timeout 5 
spawn ssh root@112.33.5.178
expect "*password*"
send "~9C3@Cbk\r"
interact
