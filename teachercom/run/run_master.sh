#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     静态主服务器操作
# Version： 1.0

#获取二进制文件信息
fname=`mysql -hlocalhost -uroot -p123456 -e "show master status;" 2> /dev/null | tail -1 | awk '{print $1}'`
fpos=`mysql -hlocalhost -uroot -p123456 -e "show master status;" 2> /dev/null | tail -1 | awk '{print $2}'`

echo "file_name=${fname}" >> /root/binlog.info
echo "file_pos=${fpos}" >> /root/binlog.info
scp /root/binlog.info slave:/root/ &> /dev/null

#备份当前主库已有数据并发送到从服务器
sleep 2
mysqldump -hlocalhost -uroot -p'123456' --all-databases > /root/run.sql 2> /dev/null
scp /root/run.sql slave:/root &> /dev/null
