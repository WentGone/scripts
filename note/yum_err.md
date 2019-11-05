安装软件后使用yum提示cannot import name ts
解决办法：
1、下载nspr的rpm包
2、rpm2cpio nspr.rpm | cpio -idmv
3、LD_PRELOAD=./usr/lib/64/libnspr4.so
4、yum update nspr
