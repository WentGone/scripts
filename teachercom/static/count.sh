#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-22
# Desc:     查询对应主机上mydb下mytb表的表记录数
# Version： 1.0


#判断是否制定主机名
if [ $# -eq 0 ];then
    echo "没有给定需要查询的主机，请给定主机名"
    exit 2
fi
#遍历查询记录
for name in $@
do
    #判断是否能通信
    ping -c 2 ${name} &> /dev/null
    if [ $? -eq 0 ];then
        counts=`ssh ${name} 'mysql -hlocalhost -uroot -p123456 -e "select count(*) from mydb.mytb;"' 2> /dev/null | tail -1`
        if [ -z ${counts} ];then
            echo -e  "数据库服务器\033[32m[${name}]\033[0m上没有mydb库或者mytb表"
            continue
        else
            echo -e "主机\033[32m[${name}]\033[0m上的mydb库下的mytb表有\033[32m[${counts}]\033[0m条记录"
        fi
    else
        echo "主机${name}无法通信，请检查网络,跳过该主机"
        continue
    fi
done
