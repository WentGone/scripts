#!/bin/bash
#Author: Mark Li
#Date: 2019-04-30
#Version: V1
#Description: this is a shell script for install nginx

#exit-11-->yum error
#exit-12-->rely packages install failed
#exit-13-->install failed


version=nginx-1.12.2
format=tar.gz

yum clean all &> /dev/null
num=`yum repolist | tail -1 | awk '{print $2}' | sed -n 's/,//gp'`
if [ ${num} -eq 0 ];then
    echo "yum error"
    exit 11
else
    echo "yum ok"
fi

useradd -s /sbin/nologin nginx
yum -y install gcc make openssl-devel &> /dev/null
if [ $? -eq 0 ];then
    echo "system rely packages installed successful"
else
    echo "system rely packages installed failed"
    exit 12
fi

tar -xf ${version}.${format}
cd ${version}
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-stream --without-http_autoindex_module --without-http_ssi_module &> /dev/null
make &> /dev/null
make install &> /dev/null

if [ $? -eq 0 ];then
    echo "Install Successful"
else
    echo "Install Failed"
    exit 13
fi

cd ..
rm -rf ${version}

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
