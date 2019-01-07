FROM centos:latest
RUN  rm -rf /etc/yum.repos.d/*
ADD  centos.repo /etc/yum.repos.d/
RUN  yum -y install net-tools psmisc vim iproute
