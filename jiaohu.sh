#!/bin/bash
host=192.168.4.5
expect << EOF
spawn scp 1.txt root@$host:/root/test/
expect "password:" { send "1\r" }
spawn scp 2.txt root@$host:/root/test/
expect "password:" {send "1\r"}
expect eof
EOF

expect << EOF
spawn ssh root@$host
expect "password:" {send "1\r"}
expect "#" {send "cd test\r"}
expect "#" {send "cat 1.txt\r"}
expect "#" {send "exit\r"}
EOF
