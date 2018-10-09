#!/usr/bin/env python2

import sys
import socket

host = ''
port = 8888

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print 'Socket Create'

try:
    s.bind((host, port))

except socket.error , msg:
    print 'bind failed'
    sys.exit()

print 'Socket bind complete'

s.listen(10)
print 'Socket now listening'

conn, addr = s.accept()

print 'connect with ' + addr[0] + ':' + str(addr[1])

data = conn.recv(1024)
conn.sendall(data)

conn.close()
s.close()
