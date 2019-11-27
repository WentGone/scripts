#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     静态主服务器操作
# Version： 1.0

#开启二进制日志
sed -ri '/server_id/s/^#//' /etc/my.cnf
sed -ri '/log_bin/s/^#//' /etc/my.cnf
sed -ri '/binlog_format/s/^#//' /etc/my.cnf
#重启服务
systemctl restart mysqld

#登录MySQL服务创建数据库
mysql -hlocalhost -uroot -p'123456' 2> /dev/null << EOF
reset master;
grant replication slave on *.* to repluser@'192.168.1.2' identified by '123456';
create database mydb;
EOF

#获取二进制文件信息
fname=`mysql -hlocalhost -uroot -p123456 -e "show master status;" 2> /dev/null | tail -1 | awk '{print $1}'`
fpos=`mysql -hlocalhost -uroot -p123456 -e "show master status;" 2> /dev/null | tail -1 | awk '{print $2}'`

echo "file_name=${fname}" >> /root/binlog.info
echo "file_pos=${fpos}" >> /root/binlog.info
scp /root/binlog.info slave:/root/ &> /dev/null

#备份当前主库已有数据并发送到从服务器
mysqldump -hlocalhost -uroot -p'123456' --all-databases > /root/all.bak 2> /dev/null
scp /root/all.bak slave:/root &> /dev/null
