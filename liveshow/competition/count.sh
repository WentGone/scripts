#!/bin/bash
awk '{ips[$1]++} END{for (ip in ips) {print ip,ips[ip]}}' web.log > 1.txt
cat 1.txt | awk '{print $1}' > 2.txt

for ip in `cat 2.txt`
do
	counts=`cat 1.txt | grep ${ip} | awk '{print $2}'`
	echo "IP地址是${ip}的这台主机访问服务器${counts}次"
done

rm -rf 1.txt 2.txt
