#!/bin/bash
for i in `seq 3`
do
	read -p "enter: " num$i
	x=num$i
	if [ -z $x ];then
		exit 33
	fi
	echo exit
	exit 34
done
