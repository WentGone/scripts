#!/bin/bash
#the high script for nginx

pro=/usr/local/nginx/sbin/nginx
conf=/usr/local/nginx/conf/nginx.conf
on="nginx is running now!"
off="nginx is not running now!!"

report(){
	[ $? -eq 0 ] && echo ${on} || echo ${off}
}

input_error(){
	echo "You must usage {start|stop|restart|reload|status}"
}

status(){
	netstat -antpu | grep nginx > /dev/null
}

start(){
	status
	if [ $? -eq 0 ];then
		echo ${on}
	else
		${pro} -c ${conf}
		report
	fi
}

stop(){
	status
	if [ $? -eq 0 ];then
		echo ${on}
		pkill nginx
		[ $? -eq 0 ] && echo ${off}
	else 
		echo ${off}
	fi
}

reload(){
	status
	if [ $? -eq 0 ];then
		echo ${on}
		${pro} -s reload -c ${conf}
		[ $? -eq 0 ] && echo "nginx reload successful, running now!" || echo "nginx reload failed!"
	else
		echo ${off}
		${pro} -c ${conf}
		report
	fi
}

case $1 in
start)
	start;;
stop)
	stop;;
status)
	status
	report;;
restart)
	stop
	start;;
reload)
	reload;;
*)
	input_error
esac
