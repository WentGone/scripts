#!/bin/bash
for each in `ls base`
do
    for i in `cat base/${each}`
    do
        cat total.txt | grep $i >> 1.txt
    done
    
    cat 1.txt | awk '{print $3}' | sed '/%/s/%$//' > 2.txt
    
    result=0
    for i in `cat 2.txt`
    do
        result=`echo $result + $i | bc -l`
    done
    count=`cat 2.txt | wc -l`
    res=`echo $result/$count | bc -l`
    echo $each    $res    $count
    rm -rf 1.txt 2.txt
done
