from centos
run yum -y install net-tools vim bind-utils
run locale && localedef -i zh_CN -c -f UTF-8 zh_CN.UTF-8 
run echo "export LC_ALL=zh_CN.UTF-8" >> /etc/profile && source /etc/profile
env LANG=zh_CN.UTF-8
env LC_CTYPE zh_CN.UTF-8
workdir /root
cmd ["/bin/bash"]
