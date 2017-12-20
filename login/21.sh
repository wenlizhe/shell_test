#!/usr/bin/expect  
set timeout 5 
spawn ssh root@112.33.14.21 -p 30022
expect "*password*"
send "Juphoon963.\r"
interact

