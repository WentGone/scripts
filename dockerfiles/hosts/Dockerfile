from centos:latest
workdir /etc/yum.repos.d/
run rm -rf *.repo 
add dvd.repo .
workdir /root
cmd echo "172.17.0.1 vip.tedu.cn" >> /etc/hosts;cat /dev/random
