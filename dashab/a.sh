#!/bin/bash
for i in `ls *$1`
do
	echo ${i%$1} >> 1.txt
done
sed -i '/[0-9]/d' 1.txt
for i in `cat 1.txt`
do
	mv $i$1 $i$2
done
rm -rf 1.txt
