#!/bin/bash
i=1
while [ $i -le 5 ]
do
    read -p "Enter a number: " num
    ls testdir | grep ${num}.txt > /dev/null
    if [ $? -eq 0 ];then
        echo "Already exist"
    else
        touch testdir/${num}.txt
        echo "create file"
        break
    fi
    let i++
done
