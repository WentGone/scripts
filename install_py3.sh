#!/bin/bash
yum clean all &> /dev/null
Pag_num=`yum repolist | tail -1 | awk '{print $2}' | sed -n 's/,//p'`
if [ ${Pag_num} -ne 0 ];then
    echo "yum可用"
else
    echo "yum不可用，请退出检查"
    exit 116
fi

yum -y install gcc gcc-c++ openssl-devel libffi-devel readline-devel zlib-devel tk-devel sqlite-devel
if [ $? -eq 0 ];then
    echo "依赖安装成功"
else
    echo "依赖安装失败"
    exit 117
fi

tar -xf Python-3.6.5.tgz
cd Python-3.6.5
./configure --prefix=/usr/local --with-ssl
make 
make install
if [ $? -eq 0 ];then
    clear
    echo "Python3安装成功"
else
    clear
    echo "Python3安装失败"
fi

cd ..
rm -rf Python-3.6.5

