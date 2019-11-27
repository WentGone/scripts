#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     模拟静态主从同步构建
# Version： 1.0

clear
#主服务器操作
echo "##########主服务器操作#########"
st ./static_master.txt
sleep 2
scp ./static_master.sh root@192.168.1.1:/root &> /dev/null
ssh root@192.168.1.1 bash /root/static_master.sh 2> /dev/null


#从服务器操作
echo "##########从服务器操作##########"
st ./static_slave.txt
sleep 2
scp ./static_slave.sh root@192.168.1.2:/root &> /dev/null
ssh root@192.168.1.2 bash /root/static_slave.sh 2> /dev/null

#主服务器验证
echo "##########主服务器验证##########"
st ./static_master_res.txt
sleep 2
scp ./static_master_res.sh root@192.168.1.1:/root &> /dev/null
ssh root@192.168.1.1 bash /root/static_master_res.sh 2> /dev/null

#从服务器验证
echo "##########从服务器验证##########"
st ./static_slave_res.txt
sleep 2
scp ./static_slave_res.sh root@192.168.1.2:/root &> /dev/null
ssh root@192.168.1.2 bash /root/static_slave_res.sh 2> /dev/null

#结果验证
echo "##########结果验证##########"
bash ./count.sh master slave
