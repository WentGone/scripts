#!/bin/bash
for i in `cat cleanstu/clean.txt`
do
    cat base/* | grep $i >> clean.tmp
done

for i in `ls base`
do
    for j in `cat clean.tmp`
    do
        cat base/$i | grep $j > /dev/null
        [ $? -eq 0 ] && echo "$j 在 ${i%.txt}"
    done
done
rm -rf clean.tmp
