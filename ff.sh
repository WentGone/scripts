#!/bin/bash
cecho(){
    echo -e "\033[$1m$2\033[0m"
    }

num=$[RANDOM%100+1]
while :
do
    read -p "请输入数字：" cai
    if [ $cai -eq $num ];then
        cecho 31 猜对了
        exit
    elif [ $cai -gt $num ];then
        cecho 32 猜大了
    else
        cecho 34 猜小了
    fi
done
