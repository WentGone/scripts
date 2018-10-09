#!/bin/bash
x=1
for i in {1..9}
do
  x=$[($x+1)*2]
done
echo $x
