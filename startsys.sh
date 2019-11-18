#!/bin/bash
# Author: Mark Li
# Date:	  2019-11-18
# Desc:   设置双系统默认启动系统

# --exit--
# 9-配置文件设置错误，严重
# 3-当前的默认系统满足需求
# 2-输入有误


sysfile="/boot/efi/EFI/centos/grubenv"

sys=`grub2-editenv list | awk -F'=' '{print $2}'`


case $1 in
now)
	if [ ${sys} == "CentOS" ];then
		echo "The Default Load System is CentOS"
	elif [ ${sys} == "Windows" ];then
		echo "The Default Load System is Windows"
	else
		echo "Setting Errors"
		exit 9
	fi
	;;
centos)
	if [ ${sys} != "CentOS" ];then
		sed -ri -e '4s/^#//' -e '3s/^/#/' ${sysfile}
		echo "Changed Successful"
	else
		echo "No Need to Change"
		exit 3
	fi
	;;
windows)
	if [ ${sys} != "Windows" ];then
		sed -ri -e '3s/^#//' -e '4s/^/#/' ${sysfile}
		echo "Changed Successful"
	else
		echo "No Need to Change"
		exit 3
	fi
	;;
*)
	echo "Useage {now|windows|linux}" >&2
	exit 2
esac 
