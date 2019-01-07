FROM  centos:latest
MAINTAINER  Mark Li mark@tedu.cn
ADD  centos.repo /root
RUN  rm -rf /etc/yum.repos.d/*
RUN  mv /root/centos.repo /etc/yum.repos.d/
RUN  yum -y install vim net-tools lftp psmisc iproute
RUN  yum -y install openssh-server
RUN  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN  ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN  ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN  echo "1" | passwd --stdin root
EXPOSE  22
CMD  ["/usr/sbin/sshd", "-D"]
