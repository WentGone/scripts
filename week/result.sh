#!/bin/bash
for each in `ls base`
do
    for i in `cat base/${each}`
    do
        cat total.txt | grep -i nsd | grep $i >> 1.txt
    done
    
    cat 1.txt | awk '{print $3}' | sed '/%/s/%$//' > 2.txt
    
    result=0
    for i in `cat 2.txt`
    do
        result=`echo ${result} + $i | bc -l`
    done
    count=`cat 2.txt | wc -l`
    res=`echo "scale=2; ${result}/${count}" | bc -l`
    echo "${each%.txt}群的达到率是${res}，活跃人数是${count}"
    rm -rf 1.txt 2.txt
done
