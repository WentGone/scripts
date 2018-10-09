#!/bin/bash
x='1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM'
pass=""
for i in {1..8}
do
	num=$[RANDOM%62+1]
	y=`echo $x | cut -b  $num`
	pass=${pass}$y
done
echo $pass
