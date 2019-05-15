DELL R730 服务器配置
#开机菜单
F2=bios设置
F10=iDRAC管理配置
F11=启动管理
F12=PXE启动
ctrl+s=网卡启动参数
ctrl+r=raid磁盘阵列配置

#设置iDRAC
#按F2进入bios
#见到三个菜单
System BIOS = 系统bios设置
iDRAC Settings  = 远程管理设置
Device Settings = 驱动设置
#首先进入系统bios设置
#进到bios菜单
系统信息
内存设置
CPU设置
磁盘设置
板载设备
串口设置
系统配置
安全与密码
其他设置
#选择串口设置，配置串口重定向
所有串口一律设置成com2

#第一项设置成On with Console Redirection via COM2
#第二项设置成Serial Device1 = COM1,Serial Device2 = COM2
#其他条目默认


#iDRAC初始化，清空所有配置
Reset iDRAC configuration to defaults
#等待进度条到100%
#完成以后点continue
#进入iDRAC Settings

#选择network
第二项NIC Selection，设置iDRAC复用那一块真实网卡
LOMn = ethn
#IPV4 SETTINGS
设置ipv4IP地址，地址设置成局域网ip，网关0.0.0.0
可以设置ipv6为disable

#IPMI SETTINGS
Enable IPMI Over Lan == Enabled

#进入Front Panel Security
设置 Set LCD message = DRAC ipv4 address

#进入User Configuration
设置密码 用户默认root

##配置完成，保存退出



#远程查看服务器是否开机
ipmitool -l lanplus -U root -H 192.168.0.120 power status
#远程开机
ipmitool -l lanplus -U root -H 192.168.0.120 power on
#远程关机
ipmitool -l lanplus -U root -H 192.168.0.120 power off

#远程设置bios、raid
ipmitool -l lanplus -U root -H 192.168.0.120 sol activate
#按ctrl+r，可以见到配置raid的界面，跟在服务器本地一样
#配置完成后在本地显示需要按ctrl+alt+delete重启服务器
#远程执行命令重启服务器
ipmitool -l lanplus -U root -H 192.168.0.120 power reset
#在执行进入配置bios、raid的界面
ipmitool -l lanplus -U root -H 192.168.0.120 sol activate
#见到菜单按f2配置bios

##然后可以选择pxe安装系统
