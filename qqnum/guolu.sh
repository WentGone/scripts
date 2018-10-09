#!/bin/bash
for i in `cat $1`
do
	cat jilu.txt | grep $i > /dev/null
	if [ $? -ne 0 ];then
		echo $i
	fi
	
done
