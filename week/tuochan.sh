#!/bin/bash
for i in `ls base`
do
    for j in `cat base/$i`
    do
        cat total.txt | grep -i nsd | grep $j > /dev/null
        [ $? -ne 0 ] && echo "${i%.txt}的$j"
    done
done
