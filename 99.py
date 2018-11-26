#!/usr/bin/env python3
import sys

def cfb(n=9):
    for i in range(1,n+1):
        for j in range(1,i+1):
            print("%s x %s = %s\t" % (j, i, i*j), end="")
        print()

if __name__ == '__main__':
    n = input('请输入需要打印的行数：')
    if n == "":
        cfb()
    else:
        try:
            n = int(n)
        except ValueError:
            print("输入非数字")
            sys.exit()
        cfb(n)
