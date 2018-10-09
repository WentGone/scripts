#!/bin/bash
for i in `ls *$1`
do
	j=`echo ${i%$1} | awk '!/[0-9]/{print $1}'`
	echo $j
done
