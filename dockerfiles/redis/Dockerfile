from centos:latest
add redis-3.0.6.tar.gz /root
workdir /root/redis-3.0.6/
run yum -y install gcc gcc-c++ make && make MALLOC=libc && make install
add redis.conf /etc/
workdir /root
expose 6379
cmd ["redis-server", "/etc/redis.conf"]
