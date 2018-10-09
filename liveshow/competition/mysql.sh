#!/bin/bash
netstat -antpu | grep :3306 > /dev/null
if [ $? -eq 0 ];then
	echo "MySQL服务是启动状态！"
else 
	echo "MySQL服务是关闭状态！"
fi
