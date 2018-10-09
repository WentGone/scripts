#!/bin/bash
sj=`date +%s%N | md5sum | head -c 6`
echo $sj

read -p 'input' b
if [ "$b" == "$sj" ]
then echo ok
else echo no
fi
