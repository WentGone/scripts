FROM  centos:latest
MAINTAINER Mark Li
ADD  centos.repo /root
RUN  rm -rf /etc/yum.repos.d/*
RUN  mv /root/centos.repo /etc/yum.repos.d
RUN  yum -y install net-tools vim psmisc iproute lftp
RUN  yum -y install openssh-server
RUN  echo "1" | passwd --stdin root
WORKDIR  /root
ADD  run.sh /
EXPOSE  22
ENTRYPOINT  ["/bin/bash", "/run.sh"]
CMD ["/bin/sh", "-c"]
