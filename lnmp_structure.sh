#!/bin/bash

menu_china(){
    echo "###########安装程序列表###############"
    echo "# 1. 安装 Nginx"
    echo "# 2. 安装 Mysql"
    echo "# 3. 安装 PHP"
    echo "# 4. 安装 JAVA"
    echo "# 5. 安装 Tomcat"
    echo "# 6. 安装 Tomcat-Session"
    echo "# 7. 安装 Memcached and PHP-MEM"
    echo "# 8. 安装 Varnish"
    echo "# 9. 安装 Redis"
    echo "# q. 退出程序"
    echo "#######################################"
}

menu_usa(){
    echo "########Install Softwares List#########"
    echo "# 1. Install Nginx"
    echo "# 2. Install Mysql"
    echo "# 3. Install PHP"
    echo "# 4. Install JAVA"
    echo "# 5. Install Tomcat"
    echo "# 6. Install Tomcat-Session"
    echo "# 7. Install Memcached and PHP-MEM"
    echo "# 8. Install Varnish"
    echo "# 9. Install Redis"
    echo "# q. Exit Install Program"
    echo "#######################################"
}

list_menu(){
    lang=`echo $LANG | awk -F. '{print $1}' | awk -F_ '{print $1}'`
    if [ ${lang} == 'zh' ];then
        menu_china
        read -p "请输入需要安装软件的编号：" select
    elif [ ${lang} == 'en' ];then
        menu_usa
        read -p "Please make choice and enter the item number：" select
    else
        echo "语言设置不识别，请先将系统语言设置成中文或英文"
        exit 110
    fi
}

while :
do
    list_menu
    case $select in
        1)
            echo "INSTALL_NGINX";;
        2)
            echo "INSTALL_MYSQL";;
        3)
            echo "INSTALL_PHP";;
        4)
            echo "INSTALL_JAVA";;
        5)  
            echo "INSTALL_TOMCAT";;
        6)
            echo "INSTALL_TOMCAT_SESSION";;
        7)
            echo "INSTALL_MEM_MEM&PHP";;
        8)
            echo "INSTALL_VARNISH";;
        9)
            echo "INSTALL_REDIS";;
        q)
            echo "EXIT_PROGRAM"
            exit 0;;
        *)
            continue;;
    esac
    sleep 2
    clear
done



