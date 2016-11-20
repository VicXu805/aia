#!/usr/bin/expect
spawn git push origin master
expect "Username"
send "837458581@qq.com\r"
expect "Password"
send "a123456\r"
expect eof
exit
