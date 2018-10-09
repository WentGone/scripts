#!/bin/bash
file=/root/.ssh/authorized_keys
checkfile() {
    if [ -f $file ];then
        echo "$file exist"
    else
        echo "$file not exist"
        touch $file
    fi
}

expect << EOF
spawn ssh 192.168.4.10
expect {
    "yes/no" {send "yes\r";exp_continue}
    "password" {send "1\r"}
    }
expect "#" {send checkfile\r}
expect "#" {send "exit\r"}
EOF
