#!/usr/bin/env python

fibs = [0,1]

for i in range(8):
     fibs.append(fibs[-1]+fibs[-2])
print fibs

for i in range(len(fibs)):
    print "index %d is %d" % (i,fibs[i])

for i, element in enumerate(fibs):
    print "index %d is %d" % (i,element)
