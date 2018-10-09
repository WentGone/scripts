#!/bin/bash
#read a name and answer according to the rules
read -p " please input your name " name
case $name in
   "lee")
    echo " hi,Lee "
    ;;
   "Neo")
    echo " not exit "
    ;;
   "other")
    echo " ok,you win "
esac
