#!/bin/bash
for i in $(ls /root/test/*.doc)
do
   path=$(dirname $i)
   name=$(basename $i)
   rename=${name/doc/ttt}
   mv $i $path/$rename

done
