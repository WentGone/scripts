#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     模拟动态主从同步构建(主服务器)
# Version： 1.0

#重置主服务器master信息
mysql -hlocalhost -uroot -p'123456' 2> /dev/null << EOF
reset master;
EOF
#用innobackupex命令备份所有数据
innobackupex --slave-info --user root --password 123456 --no-timestamp /allbak &> /dev/null
#对备份数据打包
tar -zcvPf allbak.tar.gz /allbak/ &> /dev/null
#发送备份数据包到从服务器
scp /root/allbak.tar.gz slave:/root/ &> /dev/null
