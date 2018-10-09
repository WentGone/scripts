#!/bin/bash
host=192.168.4.1
expect << EOF
spawn ssh root@$host
expect "password:" { send "1\r" }
expect "#" { send "echo 'test' > /root/2.txt\r" }
EOF
