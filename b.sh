#!/bin/bash
expect << EOF
spawn ssh root@192.168.4.4
expect "password" {send "1\r"}

expect "#" {send "echo $HOSTNAME\r"}
expect "#" {send "echo \\\$HOSTNAME\r"}
expect "#" {send "exit\r"}
EOF
