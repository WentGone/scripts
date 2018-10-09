#!/usr/bin/env python2

import socket
import sys

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

except socket.error, msg:
    print 'failed to create socket. error code: ' + str(msg[0]) + ', error message : ' + msg[1]
    sys.exit()

print 'Socket Create' 

host = 'www.sohu.com'
port = 80

try:
    remote_ip = socket.gethostbyname(host)

except socket.gaierror:
    print 'hostname could not be resolved '
    sys.exit()

print 'ip address of ' + host + ' is ' + remote_ip 


s.connect((remote_ip , port))

print 'Socket Connect to ' + host + ' on ip ' + remote_ip


message = "GET / HTTP/1.1\r\n\r\n"

try:
    s.sendall(message)
except socket.error:
    print 'send failed'

print 'Message send successfully'

reply = s.recv(4096)

print reply

s.close()

