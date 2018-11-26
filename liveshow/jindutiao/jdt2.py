#!/usr/bin/env python3

import time
import sys

def rotato_line(n=20):
    i = 0
    while True:
        left = '#' * i
        right = '#' * (n-i)
        print("\r%s@%s" % (left, right), end="")
        i = i + 1
        try:
            time.sleep(0.2)
        except KeyboardInterrupt:
            sys.exit()
        if i == n+1:
            i = 0

if __name__ == '__main__':
    rotato_line(40)
