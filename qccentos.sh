#!/bin/bash
base_xml="/var/lib/libvirt/images/.centos_tem.xml"
base_img="/var/lib/libvirt/images/.centos_tem.qcow2"

cat ${base_xml} > /tmp/mycentos.xml

read -p "Enter VM number: " num 

if [ ${num} -le 9 ]; then
    num=0${num}
fi

if [ -z "${num}" ]; then
    echo "You Must Input a number."
    exit 65
elif [ $(echo ${num}*1 | bc) = 0 ]; then
    echo "You Must Input a number."
    exit 66
elif [ ${num} -lt 1 -o ${num} -gt 99 ]; then
    echo "The Number Which You Input Is Out of Range."
    exit 67
fi


new_name="centos_node${num}"

sed -ri 's/\.centos/centos/' /tmp/mycentos.xml
sed -ri "s/centos_tem/${new_name}/" /tmp/mycentos.xml

if [ -e /var/lib/libvirt/images/${new_name}.qcow2 ]; then
    echo "${newvm}.qcow2 is exists."
    exit 68
fi

echo -en "Creating Virtual Machine disk image...\t"
qemu-img create -f qcow2 -b ${base_img} /var/lib/libvirt/images/${new_name}.qcow2 10G > /dev/null
if [ $? -eq 0 ]; then
    echo -e "\e[32;1m[OK]\e[0m"
else
    echo "created ${new_name}.qcow2 failed.."
    exit 69
fi


virsh define /tmp/mycentos.xml > /dev/null
if [ $? -eq 0 ]; then
    echo -e "created ${new_name}\t\t\033[32;1m[ok]\033[0m"
else 
    echo "define ${new_name} failed .."
    exit 70
fi

