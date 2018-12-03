#!/bin/bash
info=`cat ifs.txt`

IFS="," read name age salary <<< $info
echo $name
echo $age
echo $salary 
