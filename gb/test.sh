#!/bin/bash
rm -rf /root/.ssh/known_hosts

for i in {1..2}
do
    host=$(sed -n "${i}p" a.txt | awk '{print $1}')
    password=$(sed -n "${i}p" a.txt | awk '{print $2}')

    expect << EOF
    spawn ssh root@$host
    expect "yes/no" { send "yes\n" }
    expect "password" {send "${password}\n" }
    expect "#" {send "echo hello\n" }
    expect "#" {send "exit\n" }
EOF
done
