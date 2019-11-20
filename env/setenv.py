#!/usr/bin/env python3
# Author:   Mark Li
# Date:     2019-11-20
# Desc:     为虚拟机的eth0网卡配置IP地址
# Version:  1.0

import os
import sys
import re
import subprocess

######exit######
#2-->没有位置参数
#3-->位置参数1不是纯数字
#4-->重启network服务失败

#配置IP地址、网关、DNS
try:
    num = sys.argv[1]
except IndexError:
    print('None ip address has given')
    sys.exit(2)

for i in num:
    if not i.isdigit():
        print('Input args is not a digit')
        sys.exit(3)

ipaddr = 'IPADDR=192.168.1.%s\n' % num
netmask = 'PREFIX=24\n'
gateway = 'GATEWAY=192.168.1.254\n'
dns = 'DNS1=192.168.1.254\n'

static_set = [ipaddr, netmask, gateway, dns]

ip_fname = '/etc/sysconfig/network-scripts/ifcfg-eth0'
new = []
with open(ip_fname, "r+") as fobj:
    lines = fobj.readlines()
    for line in lines:
        m = re.search('BOOTPROTO', line)
        if m:
            n = re.sub('"dhcp"','"static"', line)
            new.append(n)
        else:
            new.append(line)

    for item in static_set:
        new.append(item)

with open(ip_fname, 'r+') as fobj:
    fobj.writelines(new)

#重启network服务
res = subprocess.call('systemctl restart network', shell=True)
if res == 0:
    print('IP address set \033[32msuccessful\033[0m')
else:
    print('IP address set \033[31mfailed\033[0m')
    sys.exit(4)

#配置主机名
host_fname = '/etc/hostname'

with open(host_fname, 'w+') as fobj:
    if int(num) < 10:
        num = '0%s' % num
    else:
        num = '%s' % num

    hostname = 'node%s.tedu.cn\n' % num
    fobj.write(hostname)

#删除配置文件
os.remove(sys.argv[0])
res = subprocess.call('clear', shell=True)
