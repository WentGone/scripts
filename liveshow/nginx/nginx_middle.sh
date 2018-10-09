#!/bin/bash
# the script for nginx

pro=/usr/local/nginx/sbin/nginx
conf=/usr/local/nginx/conf/nginx.conf
status(){
	netstat -antpu | grep nginx > /dev/null
}

if [ $1 == 'start' ];then
	status
	if [ $? -eq 0 ];then
		echo "nginx is already running!!"
	else
		${pro} -c ${conf}
		[ $? -eq 0 ] && echo "start successful!" || echo "start failed!"
	fi
elif [ $1 == 'stop' ];then
	status
	if [ $? -ne 0 ];then 
		echo "nginx is already not running!!"
	else
		pkill nginx
		[ $? -eq 0 ] && echo "stop successful!" || echo "stop failed"
	fi
elif [ $1 == 'restart' ];then
	status
	if [ $? -ne 0 ];then
		echo "nginx is not running now!"
		${pro} -c ${conf}
		[ $? -eq 0 ] && echo "restart successful!" || echo "restart failed!"
	else
		pkill nginx
		echo "stopping now!"
		${pro} -c ${conf}
		[ $? -eq 0 ] && echo "restart successful!" || echo "restart failed!"
	fi
elif [ $1 == 'reload' ];then
	status
	if [ $? -eq 0 ];then
		echo "nginx is running now!"
		${pro} -s reload -c ${conf}
		[ $? -eq 0 ] && echo "nginx reload successful!" || echo "nginx reload failed!"
	else 
		echo "nignx is not running now!"
		${pro} -c ${conf}
		[ $? -eq 0 ] && echo "start nginx" || echo "not start nginx"
	fi
elif [ $1 == 'status' ];then
	status
	[ $? -eq 0 ] && echo "nginx is running!" || echo "nginx is stopped!"
else
	echo "You must usage {start|stop|status|reload|restart}!"
fi
