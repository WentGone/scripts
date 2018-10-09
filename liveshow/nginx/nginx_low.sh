#!/bin/bash
#the script for nginx

pro=/usr/local/nginx/sbin/nginx
conf=/usr/local/nginx/conf/nginx.conf

if [ $1 == 'start' ];then
	${pro} -c ${conf}
	echo "starting now"
elif [ $1 == "stop" ];then
	pkill nginx
	echo "stopped now!"
elif [ $1 == "restart" ];then
	pkill nginx
	${pro} -c ${conf}
	echo "restart already"
elif [ $1 == 'reload' ];then
	${pro} -s reload -c ${conf}
	echo "reload already"
elif [ $1 == "status" ];then
	netstat -antpu | grep nginx > /dev/null
	[ $? -eq 0 ] && echo "nginx is on" || echo "nginx is off"
else
	echo "You must usage {start|stop|restart|reload|status}"
fi
