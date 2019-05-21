#!/bin/bash
#作者： Mark Li
#日期： 2019-05-17
#版本： v1
#描述： 这是一个为了安装zabbix的shell脚本

##安装列表
#安装服务端还是客户端
menu(){
    echo -e "#######INSTALL LIST#######"
    echo -e "1. Install zabbix \033[31m[server]\033[0m"
    echo -e "2. Install zabbix \033[32m[agent]\033[0m"
    echo -e "##########################"
}
#监控web页面运行平台
plat_menu(){
    echo -e "###########PLATFORM LIST############"
    echo -e "1. Install zabbix server on \033[31m[LAMP]\033[0m"
    echo -e "2. Install zabbix server on \033[32m[LNMP]\033[0m"
    echo -e "####################################"
}

##web平台
#检查yum
check_yum(){
    yum clean all &> /dev/null
    num=`yum repolist | tail -1 | awk '{print $2}' | sed -n 's/,//gp'`
    if [ ${num} -eq 0 ];then
        echo "yum error"
        exit 1      #yum不可用
    else
        echo "yum ok"
    fi
}
#nginx安装函数
in_nginx(){
    if [ -e nginx-1.12.2.tar.gz ];then
        #创建nginx用户
        id nginx &> /dev/null
        if [ $? -ne 0 ];then
            useradd -s /sbin/nologin nginx
        fi
    
        #安装依赖包
        yum -y install gcc make openssl-devel &> /dev/null
        if [ $? -eq 0 ];then
            echo "system rely packages installed successful"
        else
            echo "system rely packages installed failed"
            exit 12
        fi
        #安装nginx
        tar -xf nginx-1.12.2.tar.gz
        cd nginx-1.12.2
        ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-stream --without-http_autoindex_module --without-http_ssi_module &> /dev/null
        make &> /dev/null
        make install &> /dev/null
        
        if [ $? -eq 0 ];then
            echo "NGINX install successful!"
        else
            echo "NGINX install failed!"
            exit 2      #nginx安装失败
        fi
        
        cd ..
        rm -rf nginx-1.12.2
        #编写nginx服务脚本
        cat >  /usr/lib/systemd/system/nginx.service << EOF
[Unit]
Descrition=nginx - high performance web server
Documentation=http://nginx.org/en/docs
After=network.target

[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
    else
        echo "Source packge nginx is not exist!"
        exit 1          #nginx源码包不存在
    fi 
}

#php-fpm安装函数
in_php-fpm(){
    if [ -e php-fpm-5.4.16-42.el7.x86_64.rpm ];then
        rpm -ivh --nodeps php-fpm-5.4.16-42.el7.x86_64.rpm &> /dev/null
    else
        echo "php-fpm rpm package is not exist"
        exit 3          #php-fpm的rpm包不存在
    fi
}

#修改nginx配置文件
set_nginx(){
    cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.bak
    
    sed -ri '/index.html/{/#/!s/index.html/index.php/}' /usr/local/nginx/conf/nginx.conf
    sed -ri '65,71s/#//' /usr/local/nginx/conf/nginx.conf
    sed -ri '/fastcgi_params/s/fastcgi_params/fastcgi.conf/' /usr/local/nginx/conf/nginx.conf
    sed -ri '/fastcgi_param/s/^/#/' /usr/local/nginx/conf/nginx.conf
    sed -ri '/gzip/s/#//' /usr/local/nginx/conf/nginx.conf
    
    sed -ri '/gzip/a\fastcgi_read_timeout 300;' /usr/local/nginx/conf/nginx.conf
    sed -ri '/gzip/a\fastcgi_send_timeout 300;' /usr/local/nginx/conf/nginx.conf
    sed -ri '/gzip/a\fastcgi_connect_timeout 300;' /usr/local/nginx/conf/nginx.conf
    sed -ri '/gzip/a\fastcgi_buffer_size 32k;' /usr/local/nginx/conf/nginx.conf
    sed -ri '/gzip/a\fastcgi_buffers 8 16K;' /usr/local/nginx/conf/nginx.conf
}

#修改php配置文件
set_php(){
    if [ -e php-mbstring-5.4.16-42.el7.x86_64.rpm -a -e php-bcmath-5.4.16-42.el7.x86_64.rpm ];then
        rpm -ivh --nodeps php-bcmath-5.4.16-42.el7.x86_64.rpm php-mbstring-5.4.16-42.el7.x86_64.rpm &> /dev/null
    else
        echo "php rely package is not exist!"
        exit 2              #php依赖包不存在
    fi
    
    yum -y install php-gd php-xml &> /dev/null
    
    sed -ri '/;date.timezone/s/;//' /etc/php.ini
    sed -ri '/^date.timezone/s/date.timezone =/date.timezone = Asia\/Shanghai/' /etc/php.ini
    sed -ri '/max_execution_time/s/30/300/' /etc/php.ini
    sed -ri '/post_max_size/s/8/32/' /etc/php.ini
    sed -ri '/^max_input_time/s/60/300/' /etc/php.ini
    
}

##web平台函数
platform(){
    check_yum
    #安装服务
    if [ $1 == "lamp" ];then
        echo "INSTALL HTTPD SERVICE"
        yum -y install httpd &> /dev/null
    elif [ $1 == "lnmp" ];then
        echo "INSTLL NGINX SERVICE"
        in_nginx
        in_php-fpm
    fi
    
    echo "INSTALL PHP"
    yum -y install php php-mysql &> /dev/null
    echo "INSTALL MYSQL SERVICE"
    yum -y install mariadb-server mariadb-devel &> /dev/null

    #开启服务
    if [ $1 == 'lamp' ];then
        echo "START HTTPD SERVICE"
        
        set_php
        
        mkdir -p /var/www/zabbix/
        cat > /etc/httpd/conf.d/00-zabbix.conf << EOF
<VirtualHost *:80>
    ServerName "monitor.tedu.cn"
    DocumentRoot "/var/www/zabbix/"
</VirtualHost>
EOF 
        systemctl enable httpd &> /dev/null
        systemctl start httpd &> /dev/null
        
        netstat -antpu | grep httpd &> /dev/null
        if [ $? -eq 0 ];then
            echo "HTTPD service start successful!"
        else
            echo "HTTPD service start failed!"
            exit 3          #httpd服务启动失败
        fi
    elif [ $1 == "lnmp" ];then
        set_nginx
        set_php
    
        systemctl enable nginx &> /dev/null
        systemctl start nginx &> /dev/null

        netstat -antpu | grep nginx &> /dev/null
        if [ $? -eq 0 ];then
            echo "NGINX service start successful!"
        else
            echo "NGINX service start failed!"
            exit 3          #nginx服务启动失败
        fi

        systemctl enable php-fpm &> /dev/null
        systemctl start php-fpm &> /dev/null
        
        netstat -antpu | grep php &> /dev/null
        if [ $? -eq 0 ];then
            echo "PHP-FPM service start successful!"
        else
            echo "PHP-FPM service start failed!" 
            exit 3          #php-fpm服务启动失败
        fi
    fi
    #修改/开启mysqld服务，建库，授权
    sed -ri '/\[mysqld\]/a\character_set_server="utf8"' /etc/my.cnf
    sed -ri '/\[mysqld\]/a\innodb_file_per_table=1' /etc/my.cnf
    
    systemctl enable mariadb &> /dev/null
    systemctl start mariadb &> /dev/null

    if [ $? -eq 0 ];then
        echo "MySQL service start successful!"
    else
        echo "MySQL service start failed!"
        exit 3      #MySQL服务启动失败
    fi
    
    mysql << EOF
set password=password('123456');
grant all on *.* to root@'%' identified by '123456' with grant option;
create database zabbix character set utf8;
grant all on zabbix.* to zabbix@'%' identified by 'zabbix';
grant all on zabbix.* to zabbix@'localhost' identified by 'zabbix';
delete from mysql.user where user="";
flush privileges;
EOF

    systemctl restart mariadb &> /dev/null
}

##zabbix_server函数
server(){
    #安装依赖包
    check_yum
    yum -y install gcc gcc-c++ openssl-devel net-snmp-devel curl-devel &> /dev/null
    
    #安装libevent-devel包
    if  [ -e libevent-devel-2.0.21-4.el7.x86_64.rpm ];then
        yum -y localinstall libevent-devel-2.0.21-4.el7.x86_64.rpm &> /dev/null
    else
        echo "libevent-devel package is not exist!"
        exit 2          #libevent-devel包不存在
    fi

    if [ -e zabbix-3.4.4.tar.gz ];then
        tar -xf zabbix-3.4.4.tar.gz 
        cd zabbix-3.4.4/
        ./configure --enable-server --enable-proxy --with-mysql=/usr/bin/mysql_config --with-net-snmp --with-libcurl &> /dev/null
        make &> /dev/null
        make install &> /dev/null
        
        if [ $? -eq 0 ];then
            echo "Zabbix Server install successful!"
        else
            echo "Zabbix Server install failed!"
            exit 4      #zabbix_server安装失败
        fi
        #导入数据库文件
        cd database/mysql/
        mysql -uzabbix -pzabbix zabbix < schema.sql 
        mysql -uzabbix -pzabbix zabbix < images.sql 
        mysql -uzabbix -pzabbix zabbix < data.sql 
        cd ../../        
        #拷贝网页文件 
        cd frontends/php/
        netstat -antpu | grep nginx &> /dev/null
        if [ $? -eq 0 ];then
            rm -rf /usr/local/nginx/html/*
            cp -r * /usr/local/nginx/html/
            cat >> /usr/local/nginx/html/conf/zabbix.conf.php << EOF
<?php
// Zabbix GUI configuration file.
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = 'localhost';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = 'zabbix';
\$DB['USER']     = 'zabbix';
\$DB['PASSWORD'] = 'zabbix';

// Schema name. Used for IBM DB2 and PostgreSQL.
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = 'zabbix_server';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
EOF
            chmod -R 777 /usr/local/nginx/html/*
        else
            rm -rf /var/www/zabbix/*
            cp -r * /var/www/zabbix/
            cat > /var/www/zabbix/conf/zabbix.conf.php << EOF
<?php
// Zabbix GUI configuration file.
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = 'localhost';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = 'zabbix';
\$DB['USER']     = 'zabbix';
\$DB['PASSWORD'] = 'zabbix';

// Schema name. Used for IBM DB2 and PostgreSQL.
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = 'zabbix_server';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
EOF
            chmod -R 777 /var/www/zabbix/*
        fi
        cd ../..


        cd ..
        rm -rf zabbix-3.4.4/

        #配置zabbix_server
        sed -ri '/DBHost=/s/^# //' /usr/local/etc/zabbix_server.conf
        sed -ri '/# DBPassword/s/.*/DBPassword=zabbix/' /usr/local/etc/zabbix_server.conf
        
        id zabbix &> /dev/null
        if [ $? -ne 0 ];then
            useradd -s /sbin/nologin zabbix
        fi
        zabbix_server
        sleep 2

        netstat -anptu | grep :10051 &> /dev/null
        if [ $? -eq 0 ];then
            echo "Zabbix Server start successful!"
            echo "User:admin"
            echo "Password:zabbix"
        else
            echo "Zabbix Server start failed!"
            exit 6  ##zabbix_server启动失败
        fi
    else
        echo "Source package zabbix is not exist!"
        exit 2          #zabbix源码包不存在
    fi
}

##zabbix_agent函数
agent(){
    #安装依赖包
    check_yum
    yum -y install gcc zlib-devel pcre-devel openssl-devel &> /dev/null

    #安装zabbix_agent
    if [ -e zabbix-3.4.4.tar.gz ];then
        tar -xf zabbix-3.4.4.tar.gz
        cd zabbix-3.4.4
        ./configure --enable-agent &> /dev/null
        make &> /dev/null
        make install &> /dev/null

        if [ $? -eq 0 ];then
            echo "Zabbix Agent install successful!"
            #配置zabbix-agent
            id zabbix &> /dev/null
            
            if [ $? -ne 0 ];then
                useradd -s /sbin/nologin zabbix
            fi
            
            read -p "Please input the zabbix_server's ip address: " svr_ip
            sed -ri "/^Server/s/(.*)/\1,${svr_ip}/" /usr/local/etc/zabbix_agentd.conf
            
            read -p "Please input the view name for this agent: " name
            sed -ri "/^Hostname/s/=(.*)/=${name}/" /usr/local/etc/zabbix_agentd.conf

            sed -ri "/# Unsafe/s/# //" /usr/local/etc/zabbix_agentd.conf
            sed -ri "/^Unsafe/s/0/1/" /usr/local/etc/zabbix_agentd.conf

            sed -ri "/# Enable/s/# //" /usr/local/etc/zabbix_agentd.conf
            sed -ri "/^Enable/s/0/1/" /usr/local/etc/zabbix_agentd.conf

            sed -ri "/zabbix_agentd.conf.d\/$/s/# //" /usr/local/etc/zabbix_agentd.conf

            zabbix_agentd
            sleep 2

            netstat -antpu | grep ":10050" &> /dev/null
            if [ $? -eq 0 ];then
                echo "Zabbix Agent start successful!"
            else 
                echo "Zabbix Agent start failed!"
                exit 6          #zabbix agent 启动失败
            fi
        else
            echo "Zabbix Agent install failed!"
            exit 4      #zabbix_agent安装失败
        fi
        
        cd ..
        rm -rf zabbix-3.4.4
    else
        echo "Source package zabbix is not exist!"
        exit 2      #zabbix源码包不存在
    fi
}


##主函数
clear
menu
#选择安装目标
read -p "Please make a choice from Install List: " choice
case ${choice} in
1)
    echo -e "\033[34m[INSTALL ZABBIX SERVER NOW...]\033[0m"
    sleep 2
    clear
    plat_menu
    #选择安装平台
    read -p "Please Make a choice from Platform List: " select
    case ${select} in
    1)
        echo -e "\033[34m[INSTALL LAMP PLATFORM]\033[0m"
        platform lamp
        ;;
    2)
        echo -e "\033[35m[INSTALL LNMP PLATFORM]\033[0m"
        platform lnmp
        ;;
    *)
        echo -e "You Must Make a Choice from \033[32;41m[1|2]\033[0m"
    esac
    server
    ;;
2)
    echo -e "\033[35m[INSTALL ZABBIX AGENT NOW...]\033[0m"
    agent
    ;;
*)
    echo -e "You Must Make a Choice from \033[32;41m[1|2]\033[0m"
esac
