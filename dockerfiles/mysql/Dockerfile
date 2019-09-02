from centos:latest
add mysql57-community-release-el7-11.noarch.rpm /root
workdir /root
run rpm -ivh mysql57-community-release-el7-11.noarch.rpm
workdir /etc/yum.repos.d/
run sed -ri '/gpgcheck/s/1/0/' mysql-community.repo && sed -ri '/gpgcheck/s/1/0/' mysql-community-source.repo
run yum -y install mysql-community-server mysql-community-devel net-tools
add sqldata.tar.gz /

workdir /root
expose 3306
cmd ["mysqld", "--user=mysql"]
