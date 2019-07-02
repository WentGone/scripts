#!/bin/bash

for i in 192.168.1.{1..2}
do
ssh $i -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no "date" &> /dev/null
if [ $? -eq 0 ];then
    echo "$i is have authicate"
else
    echo "$i isn't have authicat"
fi
done
