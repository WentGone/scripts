#!/bin/bash
read -p "start number: " a
read -p "end number: " b
res=1
for i in `seq $a $b`
do    
    echo $i
    res=$[$res*$i]
done
echo $res
