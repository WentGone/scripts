FROM  centos:latest
MAINTAINER  Mark Li
ADD  centos.repo /root
ADD  nginx-1.12.2.tar.gz /root
ADD  php-fpm-5.4.16-42.el7.x86_64.rpm /root
ADD  nginx.conf /root
ADD  info.php /root
ADD  run.sh /root
RUN  rm -rf /etc/yum.repos.d/*
RUN  mv /root/centos.repo /etc/yum.repos.d/
WORKDIR  /root
EXPOSE 80
EXPOSE 9000
ENTRYPOINT ["/bin/bash", "/root/run.sh"]
CMD ["/bin/bash", "-c"]
