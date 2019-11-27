#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     静态从服务器验证表记录
# Version： 1.0

mysql -hlocalhost -uroot -p'123456' -e "select count(*) from mydb.mytb;" 2> /dev/null | tail -1
if [ $? -ne 0 ];then
    exit 2
fi
