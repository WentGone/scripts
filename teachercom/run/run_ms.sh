#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-28
# Desc:     动态测试
# Version： 1.0

#主服务器操作
clear
echo "##########主服务器操作##########"
st ./run_master.txt
scp ./run_master.sh root@192.168.1.1:/root &> /dev/null
ssh root@192.168.1.1 bash /root/run_master.sh 2> /dev/null
sleep 1

#从服务器操作
clear
echo "##########从服务器操作##########"
st ./run_slave.txt
scp ./run_slave.sh root@192.168.1.2:/root &> /dev/null
ssh root@192.168.1.2 bash /root/run_slave.sh 2> /dev/null
sleep 1

#验证主从同步
echo "##########查看主从数据量#########"
for i in {1..3}
do
    bash ./count.sh master slave
    sleep 1
done
