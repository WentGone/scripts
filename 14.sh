#!/bin/bash

echo $1

if [ -d $1 ];then
    echo "$1 is a dictory"
elif [ -f $1 ]; then
    echo "$1 is a file"
else
    echo "no $1"
fi
