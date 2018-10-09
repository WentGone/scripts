#!/bin/bash
for i in `ls *$1`
do
	echo ${i%$1} >> 1.txt
done

for i in `cat 1.txt | awk '!/[0-9]/{print $1}'`
do
	mv $i$1 $i$2
done
rm -rf 1.txt
