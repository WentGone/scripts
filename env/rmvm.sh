#!/bin/bash
# Author: Mark Li
# Date:   2019-11-20
# Desc:   批量删除虚拟机
# Version: 1.0

####exit####
#2-->没有给定位置参数
#3-->给的位置参数中有非纯数字
#4-->位置参数中有0
#5-->位置参数中有大于99的数字

#11-->虚拟机关机失败
#12-->取消定义虚拟机失败

#定义变量
img_dir="/var/lib/libvirt/images/"

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
    rm_name="node${num}"
    
    #确认需要删除的虚拟机是否存在
    virsh list --all | grep ${rm_name} &> /dev/null
    if [ $? -eq 0 ];then
        #确认虚拟机是否运行
        virsh list | grep ${rm_name} &> /dev/null
        if [ $? -eq 0 ];then
            echo -e "Virtual Machine \033[31m${rm_name}\033[0m is Running"
            virsh destroy ${rm_name} &> /dev/null
            if [ $? -eq 0 ];then
                echo -e "Virtual Machine \033[32m${rm_name}\033[0m is Stopped"
            else
                echo -e "Virtual Machine \033[32m${rm_name}\033[0m Stop \033[31mFailed\033[0m"
                exit 11
            fi
        fi
        
        #删除虚拟机
        virsh undefine ${rm_name} &> /dev/null
        if [ $? -eq 0 ];then
            if [ -e ${img_dir}${rm_name}.img ];then
                rm  -rf ${img_dir}${rm_name}.img
                echo -e "Delete Virtual Machine \033[32m${rm_name}\033[0m"
            else
                echo -e "Virtual Machine ${rm_name} doesn't Have Disk File, No Need to Delete"
            fi
        else
            echo -e "\033[31mCancel Define Virtual Machine failed\033[0m"
            exit 12
        fi
    else
        if [ -e ${img_dir}${rm_name}.img ];then
            echo -e "Virtual Machine \033[31m${rm_name}\033[0m Has Disk File"
            rm -rf ${img_dir}${rm_name}.img
            echo -e "Delete \033[0m${rm_name}\033[0m's Disk File"
        else
            echo -e "Virtual Machine \033[31m${rm_name}\033[0m isn't Exist, \033[32mSkip This\033[0m"
            continue
        fi
    fi
done
