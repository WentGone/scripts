#!/bin/bash
for i in {1..254}
do
	ip=192.168.6.$i
	ping -c 2 -W 0.5 $ip > /dev/null
	if [ $? -eq 0 ];then
		echo "IP地址是${ip}的这台主机是开机状态！"
	else
		echo "IP地址是${ip}的这台主机是关机状态！"
	fi
done
