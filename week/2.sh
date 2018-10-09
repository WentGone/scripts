#!/bin/bash
for i in `cat base/2018vip2.txt`
do
    cat total.txt | grep $i | grep -iv nsd
done
