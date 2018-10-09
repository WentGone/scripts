#!/bin/bash
count=`cat user.txt | wc -l`
while :
do
	i=$[RANDOM%${count}+1]
	sed -n "${i}p" user.txt
	sleep 1
done
