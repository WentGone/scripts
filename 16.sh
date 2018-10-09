#!/bin/bash
users=$(sed -n "/bash$/s/:.*//p" /etc/passwd)
for user in $users
do
    pass=$(grep "$user" /etc/shadow)
    passwd=$(echo ${pass#*:})
    password=$(echo ${passwd%%:*})
    echo "${user}'s password is $password"
done
