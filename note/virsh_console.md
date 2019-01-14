方法1：
vim /etc/default/grub
GRUB_CMDLINE_LINUX="biosdevname=0 net.ifnames=0 console=ttyS0,115200n8"
GRUB_DISABLE_LINUX_UUID="true"
GRUB_ENABLE_LINUX_LABEL="true"
保存退出
grub2-mkconfig -o /boot/grub2/grub.cfg

方法2：
grubby --update-kernel=ALL --args="console=ttyS0"
