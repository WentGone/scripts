#!/bin/bash
read -p "name: " name
read -p "password: " pass
if [ -z $name ]; then
    echo "name inviled"
    exit
fi
pass=${pass:-123456}
echo -n "your name is $name and your password  is $pass, are you surey/n: "
read k
if [ $k == y ]:then
    useradd $name
    echo $pass | passwd --stdin $name &> /dev/null
    echo "success"
fi
