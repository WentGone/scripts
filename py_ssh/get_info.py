#!/usr/bin/env python3
import paramiko

def get_info(host, port, user, passwd, command):
    ssh = paramiko.SSHClient()
    key = paramiko.AutoAddPolicy()
    ssh.set_missing_host_key_policy(key)
    ssh.connect(host, port, user, passwd, timeout = 5)
    stdin, stdout, stderr = ssh.exec_command(command)

    for i in stdout.readlines():
        print(i)

if __name__ == '__main__':
    host = '192.168.4.5'
    port = 22
    user = 'root'
    passwd = '1'
    command = 'for i in `ls /abc`; do  md5sum /abc/$i; done'
    
    get_info(host, port, user, passwd, command)
