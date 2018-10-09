#!/bin/bash
for i in `seq 3`
do
	read -p "enter: " num$i
	x=num$i
	if [ -z $x ];then
		exit
	fi
	echo exit
	exit
done
echo 234
