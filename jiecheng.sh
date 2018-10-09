#!/bin/bash
sum=0
for i in `seq 2 $1`
do
res=1
	for j in `seq 1 $i`
	do
		res=$[res*$j]
	done
	sum=$[sum+res]
done

echo $sum
