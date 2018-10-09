#!/usr/bin/env python3
def fibs(num=6):
    fibs = [0, 1]
    for i in range(num-2):
        a = fibs[-1]
        b = fibs[-2]
        fibs.append(a+b)
    return fibs

if __name__ == '__main__':
    fibs = fibs()
    print(fibs)
