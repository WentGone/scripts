#!/usr/bin/env python3

import subprocess
import threading
import sys


def ping(ip):
  result = subprocess.call("ping -c 2 %s &> /dev/null" % ip, shell=True)

  if result:
    print("IP地址是%s的这台主机是关闭的" % ip)
  else:
    print("IP地址是%s的这台主机是开启的" % ip)

if __name__ == '__main__':
  if len(sys.argv) != 2:
    print("使用：%s网段" % sys.argv[0])
    sys.exit(1)
  net_list = sys.argv[1].split('.')
  net = '.'.join(net_list[:-1])
  ips = ("%s.%s" % (net, i) for i in range(1, 255))
  for ip in ips:
    t = threading.Thread(target=ping, args=(ip,))
    t.start()
