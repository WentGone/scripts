FROM centos:latest
ADD  epel-release-latest-7.noarch.rpm /root/
RUN  rpm -ivh /root/epel-release-latest-7.noarch.rpm && yum clean all && yum -y install nginx
WORKDIR /usr/share/nginx/html
RUN echo "test" > index.html
WORKDIR /root
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
