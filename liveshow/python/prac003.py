#!/usr/bin/env python3
#--coding: utf8--
import math
num = 1
n = 0
while n < 3:
    if math.sqrt(num + 100)-int(math.sqrt(num + 100)) == 0 and math.sqrt(num + 268)-int(math.sqrt(num + 268)) == 0:
        print('这个数字是%d'  % num)
        n += 1
    #    break
    num += 1
