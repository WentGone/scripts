#-*-coding:utf-8-*-

import socket
import time

class TimeServer(object):
    def __init__(self, host, port):
        self.addr = (host, port)
        self.serv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.serv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.serv.bind(self.addr)
        self.serv.listen(1)

    def handle_child(self, cli_sock):
        while True:
            data = cli_sock.recv(1024)
            if data.strip() == '':
                break
            cli_sock.send('[%s] %s' % (time.ctime(), data))

    def mainloop(self):
        while True:
            cli_sock, cli_addr = self.serv.accept()
            self.handle_child(cli_sock)
            cli_sock.close()
        self.serv.close()

if __name__ == '__main__':
    s = TimeServer('', 21567)
    s.mainloop()
