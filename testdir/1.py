#!/usr/bin/env python3
with open('1.txt', 'r') as f1:
  data1 = f1.readlines()

with open('2.txt', 'a') as f2:
  f2.write("\n")
  for i in data1:
     f2.write(i)

