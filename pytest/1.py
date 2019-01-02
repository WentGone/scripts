#!/usr/bin/env python3
s1 = set()
s2 = set()
with open('1.txt','r') as f1:
    while True:
        data = f1.readline()
        if not data:
            break
        s1.add(data.rstrip('\n'))
with open('2.txt','r') as f2:
    while True:
        data = f2.readline()
        if not data:
            break
        s2.add(data.rstrip('\n'))

s3 = s2 - s1
with open('3.txt','a') as f3:
    for i in s3:
        f3.write(i)
        f3.write('\n')
    
