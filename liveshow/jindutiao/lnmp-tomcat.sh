#!/bin/bash

nginx_version="nginx-1.8.0"

format='tar.gz'

nginx_dep='gcc gcc-c++ zlib-devel pcre-devel openssl-devel'

menu(){
	echo "###########安装列表############"	
	echo "# 1. 安装NGINX"
	echo "# 2. 安装MySQL"
	echo "# 3. 安装PHP"
	echo "# 4. 安装Java"
	echo "# 5. 安装Tomcat"
	echo "# 6. 安装Tomcat-Session"
	echo "# 7. 安装Memcached and PHP-MEM"
	echo "# 8. 安装Varnish"
	echo "# 9. 安装Redis"
	echo "# q. 退出脚本"
	echo "###############################"
}


choice(){
	read -p "请选择需要安装的软件：" select
}

rotate_line(){
    interial=0.1
    count=0
    while :
    do
        count=`expr ${count} + 1`
        case ${count} in 
        1)
            echo -e '-'"\b\c"
            sleep ${interial}
            ;;
        2)
            echo -e '/'"\b\c"
            sleep ${interial}
            ;;
        3)
            echo -e '|'"\b\c"
            sleep ${interial}
            ;;
        4)
            echo -e '\\'"\b\c"
            sleep ${interial}
            ;;
        *)
            count=0
        esac
    done
}

jindutiao(){
    line='########################'
    len=`echo ${line} | wc -L`
    i=0
    while :
    do
        if [ $i -eq 0 ];then
            left=""
        else
            left=`echo ${line} | cut -b 1-$i`
        fi
        j=`expr $i + 1`
        if [ $i -eq ${len} ];then
            right=""
        else
            right=`echo ${line} | cut -b $j-${len}`
        fi
        echo -ne "${left}@${right}""\r"
        sleep 0.2
        let i++
        if [ $i -gt ${len} ];then
            i=0
        fi
    done
}

check_yum(){
	yum clean all &> /dev/null
	p_num=`yum repolist | tail -1 | awk '{print $2}'`
	if [ ${p_num} != 0 ];then
		echo "yum可用"
	else
		echo "yum不可用，请配置yum源"
		exit 117
	fi
}

INSTALL_NGINX(){
	ch_ng_or_not
	check_yum
	in_nginx_dep
	in_nginx
}

ch_ng_or_not(){
	num=`find / -name nginx -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "nginx已安装"
		continue
	else
		echo "开始安装nginx"
	fi
}

in_nginx_dep(){
	jindutiao &
	disown $!
	yum -y install ${nginx_dep} &> /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then
		echo "nginx依赖包已安装"
	else
		echo "nginx依赖包安装失败，请检查"
		exit 118
	fi
}

in_nginx(){
	tar -xf ${nginx_version}.${format}
	cd ${nginx_version}
	useradd -s /sbin/nologin nginx &> /dev/null
	jindutiao &
	disown $!
	./configure --prefix=/usr/local/nginx/ --user=nginx --group=nginx --with-http_ssl_module &> /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then
		jindutiao &
		disown $!
		make &> /dev/null
		make install &> /dev/null
		res=$?
		kill -9 $!
		if [ ${res} -eq 0 ];then
			echo "nginx安装成功"
		else
			echo "nginx安装失败"
			exit 119
		fi
	else
		echo "编译失败"
		exit 119
	fi
	cd ..
	rm -rf ${nginx_version}
}

INSTALL_MYSQL(){
	ch_my_not
	check_yum
	in_mysql
}
ch_my_not(){
	num=`find / -name mysqld -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "MySQL已安装"
		continue
	else
		echo "开始安装MySQL"
	fi
}

in_mysql(){
	jindutiao &
	disown $!
	yum -y install mariadb mariadb-server mariadb-devel &> /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -ne 0 ];then
		echo "MySQL安装失败"
		exit 119
	else
		echo "MySQL安装成功"
	fi
}

INSTALL_PHP(){
	in_php_not
	check_yum
	in_php
}

in_php_not(){
	num=`find / -name php -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "php已安装"
		continue
	else
		echo "开始安装php"
	fi
}

in_php(){
	jindutiao &
	disown $!
	yum -y install php php-mysql php-gd &> /dev/null
	res1=$?
	rpm -ivh --nodeps php-fpm-5.4.16-36.el7_1.x86_64.rpm &>/dev/null
	res2=$?
	kill -9 $!
	if [ ${res1} -eq 0 -a ${res2} -eq 0 ];then
		echo "php安装成功"
	else
		echo "php安装失败，请检查"
		exit 119
	fi
}

INSTALL_JAVA(){
	ch_java_not
	check_yum
	in_java
}
ch_java_not(){
	num=`rpm -qa | grep jdk | wc -l`
	if [ ${num} -ne 0 ];then
		echo "jdk已安装，请检查版本"
		exit 119
	else
		echo "开始安装1.8版本jdk"
	fi
}

in_java(){
	jindutiao &
	disown $!
	yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless &> /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then
		echo "jdk1.8安装成功"
	else
		echo "jdk1.8安装失败"
		exit 119
	fi
}

INSTALL_TOMCAT(){
	ch_cat_not
	ch_jdk_not
	in_cat
}

ch_cat_not(){
	num=`find / -name catalina.sh | wc -l`
	if [ ${num} -ne 0 ];then
		echo "tomcat已安装"
		continue
	else
		echo "开始安装tomcat"
	fi	
}

ch_jdk_not(){
	num=`rpm -qa | grep jdk-1.8 | wc -l`
	if [ ${num} -eq 0 ];then
		echo "1.8版本jdk未安装，请先执行选项4"
		continue
	else
		echo "1.8版本jdk已安装"
	fi
}

in_cat(){
	tar -xf apache-tomcat-8.0.30.tar.gz
	mv apache-tomcat-8.0.30.tar.gz /usr/local/tomcat
	if [ $? -eq 0 ];then
		echo "tomcat安装成功"
	else
		echo "tomcat安装失败"
	fi
}

while :
do
	menu
	choice
	case ${select} in
	1)
		INSTALL_NGINX;;
	2)
		INSTALL_MYSQL;;
	3)
		INSTALL_PHP;;
	4)
		INSTALL_JAVA;;
	5)
		INSTALL_TOMCAT;;
	6)
		echo "install tomcat-session";;
	7)
		echo "install mem and php-mem";;
	8)
		echo "install varnish";;
	9)
		echo "install redis";;
	q)
		echo "退出脚本"
		exit 116
		;;
	*)
		echo "请在1-9和q之间做出选择"
		continue
	esac
	sleep 2
	clear
done
