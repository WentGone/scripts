#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     静态从服务器操作
# Version： 1.0

#设置server_id
sed -ri '/server_id/s/^#//' /etc/my.cnf
#重启服务
systemctl restart mysqld

#还原备份数据
mysql -hlocalhost -uroot -p'123456' < /root/all.bak 2> /dev/null
mysql -hlocalhost -uroot -p'123456' -e "show databases;" 2> /dev/null | grep "mydb" &> /dev/null
if [ $? -eq 0 ];then

    #设置主从同步
    f_name=`cat binlog.info | grep "file_name" | awk -F= '{print $2}'`
    f_pos=`cat binlog.info | grep "file_pos" | awk -F= '{print $2}'`
    mysql -hlocalhost -uroot -p'123456' 2> /dev/null << EOF
reset slave;
change master to master_host='192.168.1.1', master_user='repluser', master_password='123456', master_log_file="${f_name}", master_log_pos=${f_pos};
start slave;
EOF
    mysql -hlocalhost -uroot -p"123456" -e "show slave status\G;" 2> /dev/null | grep -i "running:" | grep -i "no"
    if [ $? -eq 0 ];then
        exit 3
    fi
else
    exit 2
fi
