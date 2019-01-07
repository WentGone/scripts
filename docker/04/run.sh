#!/bin/bash
nginx_version=nginx-1.12.2
format=tar.gz
php_fpm=php-fpm-5.4.16-42.el7.x86_64.rpm

yum -y install vim net-tools
yum -y install gcc make zlib-devel pcre-devel ncurses-devel openssl-devel
useradd -s /sbin/nologin nginx

tar -xf $nginx_version.$format
cd $nginx_version
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
make
make install
cd ..
rm -rf $nginx

rm -rf /usr/local/nginx/conf/nginx.conf
cp /root/nginx.conf /usr/local/nginx/conf/
cp /root/info.php /usr/local/nginx/html/


yum -y install php php-mysql
rpm -ivh --nodeps $php_fpm


/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
/usr/sbin/php-fpm --nodeamonize
