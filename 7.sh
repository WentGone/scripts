#!/bin/bash
i=1
while [ $i -le 5 ]
do
    if [ $i -eq 3 ]
        then quit
    else
        echo $i
    fi
    let i++
done
