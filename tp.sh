#!/bin/bash
if [ $# -ne 1 -a $# -ne 2 ];then
    echo "请输入一个或两个位置参数"
    exit
else
    if [ $# -eq 1 ];then
        ping -c 2 192.168.4.$1 &> /dev/null
        [ $? -eq 0 ] && echo "$1 is ok" || echo "$1 is no"
    else
        if [ $1 -gt $2 ];then
            echo "位参1必须小于位参2"
            exit
        else
            for i in `seq $1 $2`
            do
                ping -c 2 192.168.4.$i &> /dev/null
                [ $? -eq 0 ] && echo "$i is ok" || echo "$i is no"
            done
        fi
    fi
fi 
