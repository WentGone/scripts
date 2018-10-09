#!/bin/bash
clear
interial=0.1
count=0
while :
do
    count=`expr ${count} + 1`
    case ${count} in 
    1)
        echo -e '-'"\b\c"
        sleep ${interial};;
    2)
        echo -e '/'"\b\c"
        sleep ${interial};;
    3)
        echo -e '|'"\b\c"
        sleep ${interial};;
    4)
        echo -e '\\'"\b\c"
        sleep ${interial};;
    *)
        count=0
    esac
done
