#!/bin/bash
yum -y install gcc gcc-c++ zlib-devel pcre-devel openssl-devel ncurses-devel
useradd -s /sbin/nologin nginx
tar -xf nginx-1.8.0.tar.gz
cd nginx-1.8.0
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
make
make install
cd ..
rm -rf nginx-1.8.0
