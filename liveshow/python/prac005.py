#!/usr/bin/env python3
def q_sort(times=3):
    alist = []
    for i in range(times):
        num = int(input('请输入一个整数：'))
        alist.append(num)
    alist.sort()
    for item in alist:
        print(item, ' ', end='')

if __name__ == '__main__':
    q_sort()
