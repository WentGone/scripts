#!/bin/bash
for i in $(cat list.txt)
do
    ssh $i hostname &
    [ $? -eq 0 ] && echo ok
done
