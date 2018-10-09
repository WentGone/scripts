#!/bin/bash

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

while :
do
	menu
	choice
	case ${select} in
	1)
		echo "install nginx";;
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
