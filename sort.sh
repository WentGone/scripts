#!/bin/bash
for i in `seq 3`
do
read -p "enter: " num
if [ -z $num ];then
	exit 33
fi
expr $num + 1 &> /dev/null
if [ $? -eq 0 ];then
	n[$i]="${num}"
else
	exit 34
fi
done
#echo ${n[1]} ${n[2]} ${n[3]}

num1=${n[1]}
num2=${n[2]}
num3=${n[3]}
#echo $num1 $num2 $num3

for j in `echo ${n[@]}`; do echo  "$j"; done | sort -n
