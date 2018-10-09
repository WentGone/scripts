#!/usr/bin/env python
import os
import time

pid = os.fork()

if pid:
  print "In parent"
  time.sleep(10)
  print "parent exit"
else:
  print "In child"
  for i in range(5):
    print time.ctime()
	time.sleep(1)
    print "child exit"
