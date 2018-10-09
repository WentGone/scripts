#!/bin/bash
nt=`nmcli connection show | awk 'NR>1{print $4}'`
for i in ${nt}
do
    ipad=`ifconfig $i | grep "\binet\b" | awk '{print $2}'`
    echo -e $i "\t" ${ipad}
done
