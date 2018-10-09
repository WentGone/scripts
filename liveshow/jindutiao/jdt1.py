#!/usr/bin/env python3
import time

flag = ['-','/','|','\\']

i = 0
while True:
    print("\r%s" % flag[i], end="")
    i += 1
    time.sleep(0.2)
    if i == 4:
        i = 0
