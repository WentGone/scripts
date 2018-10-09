#-*-coding:utf-8-*-
#tcp客户端

import socket
import time

host = '127.0.0.1'
port = 21567
addr = (host, port)

c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
c.connect(addr)

while True:
    try:
        data = raw_input("> ")
    except (KeyboardInterrupt, EOFError):
        print '\nBye-bye'
        break

    c.send(data + '\r\n')
    print c.recv(1024)

c.close()
