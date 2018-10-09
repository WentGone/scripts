#!/bin/bash

nginx_version="nginx-1.8.0"

format="tar.gz"

nginx_dep="gcc gcc-c++ zlib-devel pcre-devel openssl-devel"

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

CHECK_YUM(){
	yum clean all > /dev/null
	p_num=`yum repolist | tail -1 | awk '{print $2}'`
	if [ ${p_num} != 0 ];then
		echo "YUM可用"
	else
		echo "YUM不可用，请重新配置"
		exit 117
	fi
}


INSTALL_NGINX(){
	CH_IN_O_N
	CHECK_YUM
	IN_NGINX_DEP
	IN_NGINX
}

CH_IN_O_N(){
	num=`find / -name nginx -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "nginx已经安装"
		continue
	else
		echo "现在开始安装nginx"
	fi
}

IN_NGINX_DEP(){
	jindutiao &
	disown $!
	yum -y install ${nginx_dep} > /dev/null
	res=$?
	kill -9 $!
	if [ $res -eq 0 ];then
		echo "已成功安装nginx依赖包"
	else
		echo "安装nginx依赖包失败，请检查"
		exit 118
	fi
}

IN_NGINX(){
	tar -xf ${nginx_version}.${format}
	cd ${nginx_version}
	useradd -s /sbin/nologin nginx &> /dev/null
	jindutiao &
	disown $!
	./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module &> /dev/null
	res=$?
	kill -9 $!
	if [ $res -eq 0 ];then
		jindutiao &
		disown $!
		make &> /dev/null
		make install &> /dev/null
		res=$?
		kill -9 $!
		if [ $res -eq 0 ];then
			echo "nginx安装成功"
		else
			echo "nginx安装失败"
		fi
	else
		echo "编译安装失败"
		exit 119
	fi
	cd ..
	rm -rf ${nginx_version}
}

while :
do
	menu
	choice
	case ${select} in
	1)
		INSTALL_NGINX;;
	2)
		echo "install mysql";;
	3)
		echo "install php";;
	4)
		echo "install java";;
	5)
		echo "install tomcat";;
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
