#!/bin/bash
li='################'
length=`echo $li | wc -L`
i=0
while :
do
    if [ $i -eq 0 ];then
        left=""
    else
        left=`echo $li | cut -b 1-$i`
    fi
    j=`expr $i + 1`
    if [ $i -eq $length ];then
        right=""
    else
        right=`echo $li | cut -b $j-$length`
    fi
    echo -ne "$left@$right""\r"
    sleep 0.5
    let i++
    if [ $i -gt $length ];then
        i=0
    fi
done
