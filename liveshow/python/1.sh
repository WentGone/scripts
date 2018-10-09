#!/bin/bash
user=`cat /etc/passwd | sed -n '/bash$/s/:.*//p'`
for i in $user
do
    cat /etc/shadow | grep "$i" | awk -F: '{print $2}'
done
