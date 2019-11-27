#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     静态主服务器建表
# Version： 1.0

#创建mytb表
mysql -hlocalhost -uroot -p'123456' 2> /dev/null << EOF
use mydb;
create table mytb(id int(2) primary key auto_increment, name char(20) not null, age int(2) not null);
EOF

#验证表记录
mysql -hlocalhost -uroot -p'123456' -e "select count(*) from mydb.mytb;" 2> /dev/null | tail -1
if [ $? -ne 0 ];then
    exit 2
fi
