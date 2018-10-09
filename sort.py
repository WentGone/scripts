#!/usr/bin/env python
def count(n):
	num_list = []
	for i in range(n):
	  num = raw_input("please input a number: ")
	  num_list.append(num)
	
	print num_list
	num_list.sort()
	print num_list

times = int(raw_input("please input the count times: "))
count(times)
