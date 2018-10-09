#!/bin/bash

img_dir=/var/lib/libvirt/images

read -p "请输入一个数："  num

if [ -z ${num} ];then
	echo "必须输入一个数"
	exit 65
fi

expr ${num} + 1 &> /dev/null
if [ $? -eq 0 ];then
	if [ ${num} -lt 0 -o ${num} -gt 99 ];then
		echo "输入的数字超出范围"
		exit 67
	else
		if [ ${num} -le 9 ];then
			num=0${num}
		fi
	fi
else
	echo "输入必须是数字"
	exit 66
fi

newvm=red7_node${num}

if [ -e ${img_dir}/${newvm}.qcow2 ];then
    echo "${newvm}.qcow2 已经存在，请更换编号"
	exit 68
fi

cat ${img_dir}/.tem.xml > /tmp/myvm.xml

sed -ri "/<name/s/tem/${newvm}/"   /tmp/myvm.xml
sed -ri "/uuid/s/(<uuid>)(.*)(<\/uuid>)/\1$(uuidgen)\3/" /tmp/myvm.xml
sed -ri "/tem.qcow2/s/.tem.qcow2/${newvm}.qcow2/" /tmp/myvm.xml

sed -ri "/aa:aa/s/aa:aa/aa:${num}/" /tmp/myvm.xml
sed -ri "/bb:bb/s/bb:bb/bb:${num}/" /tmp/myvm.xml
sed -ri "/cc:cc/s/cc:cc/cc:${num}/" /tmp/myvm.xml
sed -ri "/dd:dd/s/dd:dd/dd:${num}/" /tmp/myvm.xml


qemu-img create -f qcow2 -b ${img_dir}/.tem.qcow2 ${img_dir}/${newvm}.qcow2 > /dev/null
if [ $? -eq 0 ];then
    echo "创建前端磁盘成功"
else
	echo "创建前端磁盘失败"
	exit 69
fi

virsh define /tmp/myvm.xml >> /dev/null
if [ $? -eq 0 ];then
	echo "创建虚拟机成功"
else
	echo "创建虚拟机失败"
fi
