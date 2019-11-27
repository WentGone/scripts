#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     模拟动态主从同步构建
# Version： 1.0

clear
#主服务器操作
echo "##########主服务器操作##########"
st ./dynamic_master.txt
sleep 2
scp ./dynamic_master.sh root@192.168.1.1:/root &> /dev/null
ssh root@192.168.1.1 bash dynamic_master.sh &> /dev/null


#从服务器操作
echo "##########从服务器操作##########"
st ./dynamic_slave.txt
sleep 2
scp ./dynamic_slave.sh root@192.168.1.2:/root &> /dev/null
ssh root@192.168.1.2 bash dynamic_slave.sh &> /dev/null
