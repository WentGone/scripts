#!/bin/bash

expect << EOF
spawn ssh root@192.168.4.5
expect "yes/no" {send "yes\r";exp_continue;}
expect "password:" {send "1\r"}
expect "#" {send "echo hello\r"}
expect "#" {send "exit\r"}
EOF
