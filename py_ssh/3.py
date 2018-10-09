#!/usr/bin/env python
with open('1.txt') as f:
    for filename in f:
    #filename = f.readline()
        print filename.rstrip('\n')
