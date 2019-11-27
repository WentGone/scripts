#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     模拟动态主从同步构建(从服务器)
# Version： 1.0

#解压备份数据包
if [ -e "/root/allbak.tar.gz" ];then
    tar -xvPf /root/allbak.tar.gz -C /  &> /dev/null
else
    exit 2
fi

#做恢复数据准备工作
if [ -e "/allbak" ];then
    innobackupex --apply-log --redo-only /allbak/ &> /dev/null
else
    exit 3
fi

#停止从服务器正在运行的MySQL服务
systemctl stop mysqld

#清空从服务器的数据磁盘文件
rm -rf /var/lib/mysql/*

#恢复主服务器备份过来的数据
innobackupex --copy-back /allbak/ &> /dev/null

#启动MySQL服务
chown -R mysql.mysql /var/lib/mysql/
systemctl start mysqld

#确认主服务器二进制日志信息
f_name=`cat /var/lib/mysql/xtrabackup_info | grep "binlog" | awk '{print $4}' | awk -F, '{print $1}' | sed -n "s/'//gp"`
f_pos=`cat /var/lib/mysql/xtrabackup_info | grep "binlog" | awk '{print $6}' | sed -n "s/'//gp"`


#查看主从数据库mydb库下mytb表的表记录
mysql -hlcoalhost -uroot -p'123456' -e "select count(*) from mydb.mytb;" 2> /dev/null | tail -1

#登录从库设置主从同步
mysql -hlocalhost -uroot -p'123456' 2> /dev/null << EOF
reset slave;
change master to master_host='192.168.1.1', master_user='repluser', master_password='123456', master_log_file="${f_name}", master_log_pos=${f_pos};
start slave;
EOF

#验证同步结果

