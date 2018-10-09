#!/bin/bash
rotato_line(){
line="###############"
length=`echo ${line} | wc -L`
i=0
while :
do
    if [ $i -eq 0 ];then
        left=""
    else
        left=`echo ${line} | cut -b 1-$i`
    fi
    j=`expr $i + 1`
    if [ $i -eq ${length} ];then
        right=""
    else
        right=`echo ${line} | cut -b $j-${length}`
    fi
    echo -ne "${left}@${right}""\r"
    sleep 0.2
    let i++
    if [ $i -gt ${length} ];then
        i=0
    fi
done
}


rotato_line &
disown $!
sleep 5
kill -9 $!
