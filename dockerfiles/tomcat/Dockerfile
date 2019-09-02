from centos:latest
add apache-tomcat-8.0.30.tar.gz /root
workdir /root
run yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel net-tools  && mv apache-tomcat-8.0.30 /usr/local/tomcat/ && rm -rf /dev/random && ln -s /dev/urandom /dev/random
add mysql-connector-java-5.1.6.jar /usr/local/tomcat/lib/
add testsql.jsp /usr/local/tomcat/webapps/ROOT/
expose 8080
cmd ["/usr/local/tomcat/bin/catalina.sh", "run"]
