#!/bin/bash
for i in `seq 3`
do
	read -p "enter: " num
	if [ -z ${num} ];then
		exit
	fi
	exit
done

echo hello
echo world
