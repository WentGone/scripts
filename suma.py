#!/usr/bin/env python

sum100 = 0
counter = 0

while True:
    counter +=1
    if counter % 2:
        continue
    sum100 += counter
    if counter > 100:
        break

print "result is %d" % sum100
