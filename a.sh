#!/bin/bash

expect << EOF
spawn ssh root@192.168.4.4
expect "yes/no" {send "yes\r";exp_continue;}
expect "password:" {send "1\r"}
expect "#" {send "echo hello\r"}
expect "#" {send "sed -ri \"/Hostname/s/.*/Hostname=\\\${HOSTNAME%%.*}/\" 1.txt\r"}
expect "#" {send "exit\r"}
EOF
