#!/bin/bash
cat $1 | wc -l
for i in `cat $1`
do
	cat nsd.txt | grep $i > /dev/null
	[ $? -eq 0 ] && echo $i >> normal.txt
done

cat normal.txt | wc -l
for i in `cat $1`
do
	cat normal.txt | grep $i > /dev/null
	[ $? -ne 0 ] && echo $i >> not_ex.txt
done
cat not_ex.txt | wc -l
rm -rf normal.txt
