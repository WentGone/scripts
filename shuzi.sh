#!/bin/bash
read -p "first number: " num1
read -p "second number: " num2
read -p "third number: " num3
if [ $num1 -gt $num2 ] && [ $num2 -gt $num3 ];then
    max=$num1
    mid=$num2
    min=$num3
elif [ $num1 -gt $num3 ] && [ $num3 -gt $num2 ];then
    max=$num1
    mid=$num3
    min=$num2
elif [ $num2 -gt $num1 ] && [ $num1 -gt $num3 ];then
    max=$num2
    mid=$num1
    min=$num3
elif [ $num2 -gt $num3 ] && [ $num3 -gt $num1 ];then
    max=$num2
    mid=$num3
    min=$num1
elif [ $num3 -gt $num2 ] && [ $num2 -gt $num1 ];then
    max=$num3
    mid=$num2
    min=$num1
elif [ $num3 -gt $num1 ] && [ $num1 -gt $num2 ];then
    max=$num3
    mid=$num1
    min=$num2
fi

num1=$min
num2=$mid
num3=$max
echo $num1 $num2 $num3
