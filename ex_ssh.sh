#!/bin/bash
host=192.168.4.1
expect << EOF
spawn ssh root@$host
expect "password:" { send "1\r" }
expect "#" { send "pwd > /tmp/$USER.txt \r" }
expect "#" { send "exit\r" }
EOF
