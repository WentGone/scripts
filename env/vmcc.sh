#!/bin/bash
# Auther:   Mark
# Date:     2019-11-20
# Desc:     快建虚拟机脚本
# Version:  1.0

####exit####
#2-->没有给定位置参数
#3-->给的位置参数中有非纯数字
#4-->位置参数中有0
#5-->位置参数中有大于99的数字

#11-->创建磁盘失败
#12-->创建xml文件失败
#13-->定义虚拟机失败
#14-->磁盘文件已经存在

#定义变量
img_dir="/var/lib/libvirt/images/"
xml_dir="/etc/libvirt/qemu/"
base_name="demo"

#判定位置参数
if [ $# -eq 0 ];then
    echo -e "\033[31mNone args has given\033[0m"
    exit 2
fi

for i in $@
do
    expr $i + 1 &> /dev/null
    if [ $? -ne 0 ];then
        echo -e "\033[33m${i}\033[0m \033[31mis not digit, Please input again\033[0m"
        exit 3
    else
        if [ $i == 0 ];then
            echo -e "\033[31mVirtual ID can't be 0\033[0m"
            exit 4
        elif [ $i -gt 99 ];then
            echo -e "\033[31mVirtual ID can't grater than 99\033[0m"
            exit 5
        elif [ $i -lt 10 ];then
            num=0$i
        else
            num=$i
        fi
    fi
    new_name="node${num}"

    #创建虚拟机模板
    if [ -e ${img_dir}${new_name}.img ];then
        echo -e "\033[31mVirtual Disk File\033[0m \033[32m${new_name}.img\033[0m \033[31mis Already Exist\033[0m"
        exit 14
    else
        qemu-img create -f qcow2 -b ${img_dir}.${base_name}.img ${img_dir}${new_name}.img 10G &> /dev/null
        if [ $? -eq 0 ];then
            echo -e "Create Disk File...\t\t\t\033[32m[ok]\033[0m"
        else
            echo -e "Create Disk File...\t\t\t\033[31m[failed]\033[0m"
            exit 11
        fi
    fi
    
    #创建虚拟机配置文件
    sed -r "/${base_name}/s/${base_name}/${new_name}/" ${img_dir}.${base_name}.xml >> ${xml_dir}${new_name}.xml
    if [ $? -eq 0 ];then
        echo -e "Create XML File...\t\t\t\033[32m[ok]\033[0m"
    else
        echo -e "Create XML File...\t\t\t\033[31m[failed]\033[0m"
        exit 12
    fi
    
    #定义虚拟机
    virsh define ${xml_dir}${new_name}.xml &> /dev/null
    if [ $? -eq 0 ];then
        echo -e "Create Virtual Machine...\t\t\033[32m[ok]\033[0m"
    else
        echo -e "Create Virtual Machine...\t\t\033[31m[failed]\033[0m"
        exit 13
    fi
done
