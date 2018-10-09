#!/bin/bash
sum=0
for i in `awk -F[:] '{print $2}' jia.txt`
do
    sum=$[$sum+$i]
done
echo $sum
