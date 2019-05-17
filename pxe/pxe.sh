#!/bin/bash

##English
#Author: Mark Li
#Date: 2019-05-17
#Version: v1
#Description: This is a shell script for PXE system

##Chinese
#作者：Mark Li
#日期：2019-05-17
#版本：版本1
#描述：这是一个一键部署PXE平台的shell脚本

##通用函数
yn(){
    if [ $? -eq 0 ];then
        echo "$1 successful!"
    else
        echo "$1 failed!!"
        exit 1 
    fi
}
##检查yum
check_yum(){
    yum clean all &> /dev/null
    num=`yum repolist | tail -1 | awk '{print $2}' | sed -n 's/,//gp'`
    if [ ${num} -eq 0 ];then
        echo "yum error"
        exit 1
    else
        echo "yum ok"
    fi
}

##测试挂载
check_mount(){
    read -p "Please Input The Absolute Path for a ISO: " iso
    point="/var/ftp/pub/iso/centos/"
    [ -d ${point} ] || mkdir -p ${point}
    mount -o,loop ${iso} ${point} &> /dev/null
    yn "mount iso"
}

##安装配置服务
set_sercies(){
    #安装服务
    yum -y install vsftpd dhcp tftp-server &> /dev/null
    yn "Base Services Install"
    
    #定义虚拟网络
    systemctl enable libvirtd &> /dev/null
    systemctl restart libvirtd &> /dev/null

    cat > /etc/libvirt/qemu/networks/vbr.xml << EOF
<network>
  <name>vbr</name>
  <forward mode='nat'/>
  <bridge name='vbr'/>
  <ip address='192.168.1.254' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.1.100' end='192.168.1.200'/>
    </dhcp>
  </ip>
</network>
EOF
    virsh net-define /etc/libvirt/qemu/networks/vbr.xml &> /dev/null
    virsh net-start vbr &> /dev/null
    virsh net-autostart vbr &> /dev/null

    ifconfig vbr &> /dev/null
    yn "Virtual Network start"
    #设置dhcp服务
    mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak
    
    cat > /etc/dhcp/dhcp.conf << EOF
ddns-update-style none;
ignore client-updates;
default-lease-time 14400;
max-lease-time 86400;
allow bootp;
allow booting;
local-address 192.168.1.254;
local-port 67;

include "/etc/dhcp/subnet-192.168";
EOF

    cat > /etc/dhcp/subnet-192.168 << EOF
subnet  192.168.1.0 netmask 255.255.255.0 {
    option routers 192.168.1.254;
    option subnet-mask 255.255.255.0;
    option domain-name-servers 192.168.1.254;
    option ntp-servers 192.168.1.254;
    filename "pxelinux.0";
    next-server 192.168.1.254;
    pool {
        range dynamic-bootp 192.168.1.10 192.168.1.240;
        default-lease-time 3600;
        max-lease-time 72000;
        allow unknown-clients;
    }
}
EOF
    
    systemctl enable dhcpd &> /dev/null
    systemctl start dhcpd &> /dev/null
    yn "dhcpd serivce start"
    #设置vsftpd服务
    systemctl enable vsftpd &> /dev/null
    systemctl start vsftpd &> /dev/null
    yn "vsftpd serivce start"
    #设置tftp-server服务
    systemctl enable tftp.socket &> /dev/null
    systemctl start tftp.socket &> /dev/null
    yn "tftp service start"
}
##部署文件
set_files(){
    yum -y install syslinux &> /dev/null
    cp -p /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
    
    point="/var/ftp/pub/iso/centos"
    mkdir /var/lib/tftpboot/centos
    cp ${point}/isolinux/{vmlinuz,initrd.img} /var/lib/tftpboot/centos/

    mkdir /var/lib/tftpboot/pxelinux.cfg
    cat > /var/lib/tftpboot/pxelinux.cfg/default << EOF
default Linux
prompt 1
timeout 60

label Linux
    kernel centos/vmlinuz
    append initrd=centos/initrd.img ks=ftp://192.168.1.254/confg/ks.cfg ksdevice=bootif console=tty0 console=ttyS0,115200
EOF

    mkdir /var/ftp/conf/
    cat > /var/ftp/conf/ks.cfg << EOF
#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Install OS instead of upgrade
install
# Keyboard layouts
keyboard 'us'
# Root password
rootpw --iscrypted lxqk4My6q5YyQ
# System timezone
timezone Asia/Shanghai
# Use network installation
url --url="ftp://192.168.1.254/pub/iso/centos/"
# System language
lang en_US.UTF-8
# Firewall configuration
firewall --disabled
# System authorization information
auth  --useshadow  --passalgo=sha512
# Use text mode install
text
# Installation logging level
logging --level=warning
# Run the Setup Agent on first boot
firstboot --disable
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
# Network information
network --device=bootif --onboot=on --hostname=localhost --bootproto=bootp --noipv6
# Reboot after installation
reboot
# System bootloader configuration
bootloader --location=mbr
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part /boot --asprimary --fstype=xfs --size=512
part /     --asprimary --fstype=xfs --size=1 --grow

%packages --nobase
@Core --nodefaults
-iwl3160-firmware
-iwl6000g2b-firmware
-iwl2030-firmware
-iwl7265-firmware
-iwl1000-firmware
-iwl4965-firmware
-iwl2000-firmware
-iwl3945-firmware
-alsa-tools-firmware
-aic94xx-firmware
-iwl135-firmware
-iwl7260-firmware
-iwl6050-firmware
-iwl6000g2a-firmware
-iwl5000-firmware
-ivtv-firmware
-iwl100-firmware
-iwl5150-firmware
-iwl105-firmware
-iwl6000-firmware
-alsa-firmware
-postfix
-audit
-tuned
chrony
psmisc
net-tools
screen
vim-enhanced
tcpdump
lrzsz
ltrace
strace
traceroute
whois
bind-utils
tree
mlocate
rsync
lsof
lftp
patch
diffutils
cpio
time
nmap
socat
man-pages
rpm-build
createrepo
%end

%pre
%end

%post --interpreter=/bin/bash
rm -f /etc/yum.repos.d/*.repo
echo "[local_repo]
name=CentOS-$releasever - Base
baseurl=ftp://192.168.1.254/pub/iso/centos/
enabled=1
gpgcheck=1" > /etc/yum.repos.d/local.repo

rpm -import ftp://192.168.1.254/pub/iso/centos/RPM-GPG-KEY-CentOS-7
yum erase -y NetworkManager NetworkManager-libnm kexec-tools firewalld-filesystem polkit
sed 's,^CRONDARGS=.*,&"-m off",' -i /etc/sysconfig/crond
sed 's,^\(OPTIONS=\).*,\1"-4",'  -i /etc/sysconfig/chronyd
sed 's,^server .*,&\ncmdallow 127.0.0.1,' -i /etc/chrony.conf
sed 's,^#\(terminfo xterm \x27is.*\),\1\nterm xterm,' -i /etc/screenrc
echo '
IPV6INIT="no"
NETWORKING="yes"
NOZEROCONF="yes"
' >> /etc/sysconfig/network

echo -e "# ::1\t\tlocalhost localhost.localdomain localhost6 localhost6.localdomain6" >/etc/hosts
echo -e "127.0.0.1\tlocalhost localhost.localdomain localhost4 localhost4.localdomain4" >>/etc/hosts
echo -e 'export TZ='Asia/Shanghai' PYTHONSTARTUP="/usr/lib64/python2.7/pystartup.py" TMOUT=7200' >/etc/profile.d/environ.sh
echo -e "blacklist acpi_pad\nblacklist power_meter" >/etc/modprobe.d/blacklist.conf

echo "net.ipv4.ip_forward = 1
net.ipv4.ip_default_ttl = 255
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 0

net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
kernel.sysrq = 16
vm.swappiness = 0" > /etc/sysctl.d/70-system.conf

# config vimrc
sed -e 's,^#\(Port\).*,\1 10022,' \
    -e 's,^#\(ListenAddress 0.0.0.0\),\1,' \
    -e 's,^#\(PermitRootLogin\).*,\1 yes,' \
    -e 's,^#\(MaxAuthTries\).*,\1 3,' \
    -e 's,^#\(UseDNS\).*,\1 no,' -i /etc/ssh/sshd_config

echo '# Generated by dracut initrd
DEVICE="eth0"
ONBOOT="yes"
IPV6INIT="no"
IPV4_FAILURE_FATAL="no"
NM_CONTROLLED="no"
TYPE="Ethernet"
BOOTPROTO="dhcp"' >/etc/sysconfig/network-scripts/ifcfg-eth0 

%end
EOF
}


##测试安装
check_yum
install_services
check_mount
set_files


virt-install \
            --connect qemu:///system --virt-type kvm \
            --name demo --memory 2048 --cpu host --vcpus 2 --os-variant centos7.0 \
            --network bridge=vbr0 \
            --disk path=/var/lib/libvirt/images/demo.qcow2,bus=scsi \
            --boot menu=on,useserial=on --nographics --pxe
virsh list --all | grep demo &> /dev/null
yn "Virtual Host Install"
