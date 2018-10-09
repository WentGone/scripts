#!/usr/bin/env python

import socket

host = ''
port = 12345
addr = (host, port)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(addr)
s.listen(1)

cli_sock, cli_addr = s.accept()
print 'Client connected from:', cli_addr
print cli_sock.recv(1024),
cli_sock.send("I C U.\n")
cli_sock.close()
s.close()
