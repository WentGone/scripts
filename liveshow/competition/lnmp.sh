#!/bin/bash
# this scripts for install nginx,mysql,php,memchached,redis,tomcat
# date:20180608
# author: Mark Li
# E-mail: lijiying@tedu.cn

#		exit-->116-->make sure exit the program;
#		exit-->117-->yum is not available;
#		exit-->118-->dependence install failed;
#		exit-->119-->soft install failed;

format=tar.gz
format1=tgz
nginx_version=nginx-1.8.0
mysql_version=mysql-5.6.25
mhash_version=mhash-0.9.9.9
libmcrypt_version=libmcrypt-2.5.8
php_version=php-5.4.24
java_version=java-1.8.0
tomcat_version=apache-tomcat-8.0.30
libevent_version=libevent-2.0.21-stable
memcached_version=memcached-1.4.24
php_mem_version=memcache-2.2.5
varnish_version=varnish-3.0.6
redis_version=redis-3.0.6

rotate_line(){
	INTERVAL=0.1
	TCOUNT="0"
	while :
	do
		TCOUNT=`expr $TCOUNT + 1`
		case $TCOUNT in
		"1")
			echo -e '-'"\b\c"
			sleep $INTERVAL
			;;
		"2")
			echo -e '\\'"\b\c"
			sleep $INTERVAL
			;;
		"3")
			echo -e "|\b\c"
			sleep $INTERVAL
			;;
		"4")
			echo -e "/\b\c"
			sleep $INTERVAL
			;;
		*)
			TCOUNT="0";;
		esac
	done
}

Check_yum(){
	packages_num=`yum repolist | tail -1 | awk -F: '{print $2}' | awk '{print $1}'`
	if [ ${packages_num} != '0' ];then
		echo "yum is ok!"
	else
		echo "yum is wrong, please check the configure of yum's repo file and make sure it can be used!"
		exit 117
	fi
}

menu(){
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

choice(){
	read -p "Please make your choice for install software: " select
}

Install_Nginx_Dependence(){
	echo "Install the dependence for nginx now!!"
	yum -y install gcc gcc-c++ zlib-devel pcre-devel openssl-devel > /dev/null
	if [ $? -eq 0 ];then
		echo "The dependence for nginx is already installed now!"
	else 
		echo "The dependence for nginx is install failed, please check!"
		exit 118
	fi
}

Check_nginx_install_or_not(){
	num=`find / -name nginx -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "Nginx is already installed!"
		continue
	else
		echo "Install nginx now!!"
	fi
}

Install_Nginx(){
	Check_nginx_install_or_not
	Check_yum
	Install_Nginx_Dependence
	useradd -s /sbin/nologin nginx
	tar -xf ${nginx_version}.${format}
	cd ${nginx_version}
	rotate_line &
	disown $!
	./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-http_ssl_module &> /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then 
		rotate_line &
		disown $!
		make &> /dev/null && make install &> /dev/null
		res=$?
		kill -9 $!
		if [ ${res} -eq 0 ];then
			cp ../scripts/nginx /etc/init.d/nginx
			chmod +x /etc/init.d/nginx
			echo "Install Nginx Successful!"
		else
			echo "Install Nginx Failed!!"
			exit 119
		fi
	else
		echo "The environment is not available"
		exit 119
	fi
	cd ..
	rm -rf ${nginx_version}
}


Check_mysql_install_or_not(){
	num=`find / -name mysqld -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "Mysql is installed, please check which version is installed"
		continue
	else
		echo "Install mysql now!!"
	fi
}

Install_Mysql_Dependence(){
	echo "Install the dependence for mysql now"
	yum -y install gcc gcc-c++ ncurses-devel ncurses-libs cmake zlib-devel pcre-devel libxml2-devel > /dev/null
	if [ $? -eq 0 ];then
		echo "The dependence for mysql is already install now!"
	else
		echo "The dependence for mysql is install failed, please check!"
		exit 118
	fi
}

Install_Mysql(){
	Check_mysql_install_or_not
	Check_yum
	Install_Mysql_Dependence
	useradd -s /sbin/nologin mysql
	tar -xf ${mysql_version}.${format}
	cd ${mysql_version}
	rotate_line &
	disown $!
	cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DSYSCONFDIR=/etc -DMYSQL_DATADIR=/usr/local/mysql/data -DMYSQL_TCP_PORT=3306 -DMYSQL_USER=mysql -DEXTRA_CHARSETS=all &> /dev/null
	make install > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then
		rotate_line &
		disown $!
		make &> /dev/null 
		make install &> /dev/null
		res=$?
		kill -9 $!
		if [ ${res} -eq 0 ];then
			echo "Install Mysql Successful!"
			chown -R mysql:mysql /usr/local/mysql
			/usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql/data > /dev/null
			echo "/usr/lib/mysql/lib/" >> /etc/ld.so.conf
			ldconfig -v > /dev/null
			echo "PATH=$PATH:$HOME/bin:/usr/local/mysql/bin" >> /etc/profile
			echo "export PATH" >> /etc/profile
			source /etc/profile
			cp /usr/local/mysql/my.cnf /etc/
			cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
			chmod +x /etc/init.d/mysqld
			echo "Configure Mysql Successful!"
		else
			echo "Install Mysql Failed!!"
			exit 119
		fi
	else
		echo "The environment is not available"
		exit 119
	fi
	cd ..
	rm -rf ${mysql_version}
}


Check_PHP_Install_or_not(){
	num=`find / -name php -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "PHP is already installed ,please check which version is installed!"
		continue
	else
		echo "Install PHP now!!"
	fi

}

Install_mhash(){
	tar -xf ${mhash_version}.${format}
	cd ${mhash_version}
	./configure > /dev/null
	make > /dev/null
	make install > /dev/null
	cd ..
	rm -rf ${mhash_version}
}

Install_libmcrypt(){
	tar -xf ${libmcrypt_version}.${format}
	cd ${libmcrypt_version}
	./configure > /dev/null
	make > /dev/null
	make install > /dev/null
	cd ..
	rm -rf ${libmcrypt_version}
}

Install_PHP_Dependence(){
	Install_mhash
	Install_libmcrypt

	ln -s /usr/local/lib/libmcrypt* /usr/lib
	ln -s /usr/local/lib/libmhash.* /usr/lib
	ldconfig -v > /dev/null
	echo "Then dependence for php is install successful!!"
}

Config_PHP(){
	cp php.ini-production /usr/local/php/etc/php.ini
	cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
	cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
	chmod +x /etc/init.d/php-fpm
	echo "Comolete the initialization configuration for php!"
}

Install_PHP(){
	Check_PHP_Install_or_not
	if [ -e /usr/local/mysql ];then
		echo "Mysql is already installed , going on!!"
		Install_PHP_Dependence
		tar -xf ${php_version}.${format}
		cd ${php_version}
		rotate_line &
		disown $!
		./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --enable-fpm --enable-mbstring &> /dev/null
		make &> /dev/null
		make install &> /dev/null
		res=$?
		kill -9 $!
		if [ ${res} -eq 0 ];then
			echo "PHP install successful!"
			Config_PHP
		else 
			echo "PHP install failed, please check again"
			exit 119
		fi
		cd ..
		rm -rf ${php_version}
	else
		echo "You must make sure that Mysql is installed!"
		continue
	fi
}

Check_JAVA_Install_or_not(){
	num=`rpm -qa | grep java | wc -l`
	if [ ${num} -ne 0 ];then
		echo "Please check which version for java is already installed!"
		continue
	else
		echo "Install java now!"
	fi
}

Install_JAVA(){
	Check_JAVA_Install_or_not
	Check_yum
	rotate_line &
	disown $!
	yum -y install ${java_version}-openjdk ${java_version}-openjdk-devel ${java_version}-openjdk-headless javapackages-tools python-javapackages > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then
		echo "Install JAVA successful!"
	else
		echo "Install JAVA failed, please check again!!"
		exit 119
	fi
}


Check_Tomcat_Install_or_not(){
	if [ -e /usr/local/tomcat ];then
		echo "Tomcat is already installed, please check out the version of it!"
		continue
	else
		echo "Install Tomcat now!!"
	fi
}

Install_Tomcat(){
	Check_Tomcat_Install_or_not
	tar -xf ${tomcat_version}.${format}
	cp -rp ${tomcat_version} /usr/local/tomcat
	if [ $? -eq 0 ];then 
		echo "Install Tomcat Successful!"
		rm -rf ${tomcat_version}
	else
		echo "Install Tomcat Faild, please check again!!"
		exit 119
	fi
}

Install_Tomcat_Session(){
	if [ -e /usr/local/tomcat/ ];then
		echo "Install tomcat-session now!"
		if [ -e /usr/local/tomcat/lib/memcached-session-manager-1.9.2.jar ];then
			echo "Tomcat-Session is already installed!"
			continue
		else
			tar -xf session.${format}
			cp session/*.jar /usr/local/tomcat/lib/
			echo "Install tomcat-session successful!"
		fi
	else
		echo "Install Tomcat before do this!"
		continue
	fi
}

Check_Mem_Install_or_not(){
	num=`find / -name memcached -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "Memcached is already installed, please check out which version is installed!"
		continue
	else 
		echo "Install Memcached and PHP-Mem now!!"
	fi
}

Memcache_Menu(){
	echo "******Memcache-Install-MENU******"
	echo "# 1-Install by sound code package"
	echo "# 2-Install by yum"
	echo "# 3-Abandon the Installation"
	echo "*********************************"
	read -p "Please make a choice: " mem_select 
}

Install_by_yum(){
	Check_yum
	rotate_line &
	disown $!
	yum -y install memcached php-pecl-memcache > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -eq 0 ];then
		echo "Memcached and php-mem install successful!"
	else
		echo "Memcached and php-mem install failed, please check it out!!"
		exit 119
	fi
}

Install_Mem_Dependence(){
	Check_yum
	yum -y install autoconf > /dev/null
	tar -xf ${libevent_version}.${format}
	cd ${libevent_version}
	rotate_line &
	disown $!
	./configure > /dev/null
	make > /dev/null
	make install > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -ne 0 ];then
		echo "Install the dependence for Mem failed!!"
		exit 118
	else
		echo "Install the dependence for Mem successful!"
		echo "/usr/local/lib" >> /etc/ld.so.conf
		ldconfig -v > /dev/null
		if [ $? -ne 0 ];then
			echo "Config the libevent failed, please check!"
			exit 118
		else
			echo "Config the libevent successful!!"
		fi
	fi
	cd ..
	rm -rf ${libevent_version}
}

Install_MEM(){
	tar -xf ${memcached_version}.${format}
	cd ${memcached_version}
	rotate_line &
	disown $!
	./configure --prefix=/usr/local/memcached > /dev/null
	make > /dev/null
	make install > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -ne 0 ];then
		echo "Install Memcached failed, please check!"
		exit 119
	else
		echo "Install Memcached successful!!"
		cd ..
		rm -rf ${memcached_version}
	fi
}

Config_PHP_MEM(){
	day=`/usr/local/php/bin/phpize | grep -i module | awk -F[:] '{print $2}' | awk '{print $1}'`
	sed -i '728i extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20100525/"' /usr/local/php/etc/php.ini
	sed -i '856i extension=memcache.so' /usr/local/php/etc/php.ini	
}

Install_PHP_MEM(){
	if [ ! -e /usr/local/php ];then
		echo "You must install php before do this!"
		continue
	else:
		echo "Install PHP-MEM now!!"
		tar -xf ${php_mem_version}.${format1}
		cd ${php_mem_version}
		rotate_line &
		disown $!
		/usr/local/php/bin/phpize . > /dev/null
		./configure --with-php-config=/usr/local/php/bin/php-config --enable-memcache > /dev/null
		make > /dev/null
		make install > /dev/null
		res=$?
		if [ ${res} -ne 0 ];then
			echo "Install PHP-MEM failed, please check!"
			exit 119
		else
			echo "Install PHP-MEM successful!!"
			Config_PHP_MEM
			echo "Complete the initialization for PHP-MEM!"
			cd ..
			rm -rf ${php_mem_version}
		fi	
	fi
}

Install_by_sound_code(){
	Install_Mem_Dependence
	Install_MEM
	Install_PHP_MEM
}

Install_Memcached_and_PHP-Memcached(){
	Check_Mem_Install_or_not
	Memcache_Menu
	case ${mem_select} in
	1)
		Install_by_sound_code;;
	2)
		Install_by_yum;;
	3)
		echo "Abandon the install for Memcached"
		continue;;
	*)
		echo "You must make a choice from 1 or 2!"
		continue
	esac
}

Install_Varnish_Dependence(){
	yum -y install gcc make pcre-devel zlib-devel readline-devel > /dev/null
	if [ $? -ne 0 ];then
		echo "Install the dependence for varnish failed, please check!"
		exit 118
	else
		echo "Install the dependence for varnish successful!"
	fi
}

Config_Varnish(){
	cp redhat/varnish.initrc /etc/init.d/varnishd
	cp redhat/varnish.sysconfig /etc/sysconfig/varnish
	cp redhat/varnish_reload_vcl /usr/bin/
	ln -s /usr/local/varnish/sbin/varnishd  /usr/sbin/
	mkdir /etc/varnish
	cp /usr/local/varnish/etc/varnish/default.vcl /etc/varnish/
	uuidgen > /etc/varnish/secret
	echo "Complete the initialization of varnish!"
}

Install_Varnish(){
	Check_yum
	Install_Varnish_Dependence
	useradd -s /sbin/nologin varnish
	tar -xf ${varnish_version}.${format}
	cd ${varnish_version}
	rotate_line &
	disown $!
	./configure --prefix=/usr/local/varnish > /dev/null
	make > /dev/null
	make install > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -ne 0 ];then
		echo "Install varnish failed, please check!"
		exit 119
	else 
		echo "Install varnish successful!!"
		Config_Varnish
		cd ..
		rm -rf ${varnish_version}
	fi
}

Check_Redis_Install_or_not(){
	num=`find / -name redis-server -perm 755 | wc -l`
	if [ ${num} -ne 0 ];then
		echo "Redis is already installed, please check which version is installed!"
		continue
	else 
		echo "Install Redis now!!"
	fi
}

Install_Redis_Dependence(){
	yum -y install gcc gcc-c++ make > /dev/null
	echo "Install redis dependence successful"
}

Config_Redis(){
	ln -s /usr/local/redis/bin/* /usr/local/bin
	cp redis.conf /usr/local/redis/bin/
	sed -ri '/daemonize no/s/no/yes/' /usr/local/redis/bin/redis.conf 
	cp ../scripts/redis /etc/init.d/
	chmod +x /etc/init.d/redis
	echo "Complete the initializaion for redis!"
}

Install_Redis(){
	Check_Redis_Install_or_not
	Check_yum
	Install_Redis_Dependence
	tar -xf ${redis_version}.${format}
	cd ${redis_version}
	rotate_line &
	disown $!
	make > /dev/null
	make install PREFIX=/usr/local/redis/ > /dev/null
	res=$?
	kill -9 $!
	if [ ${res} -ne 0 ];then
		echo "Install redis failed, please check!"
		exit 119
	else
		echo "Install redis successful"
		Config_Redis
		cd ..
		rm -rf ${redis_version}
	fi
}

while :
do
	menu
	choice
	case $select in 
	1)
		Install_Nginx;;
	2)
		Install_Mysql;;
	3)	
		Install_PHP;;
	4)
		Install_JAVA;;
	5)
		Install_Tomcat;;
	6)
		Install_Tomcat_Session;;
	7)
		Install_Memcached_and_PHP-Memcached;;
	8)
		Install_Varnish;;
	9)
		Install_Redis;;
	q)
		echo "Exit the install program"
		exit 116
		;;
	*)
		echo "You must make choice from 1-9"
		continue
	esac
	sleep 3
	clear
done
