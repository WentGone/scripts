#!/usr/bin/env python
import psutil

def is_exist(pro_name):
  pid_list = psutil.pids()
  for pid in pid_list:
    if psutil.Process(pid).name() == pro_name:
	  return "running"
  else:
	  return "not running"

if __name__ == '__main__':
  pro_name = raw_input('please input process name: ')
  print is_exist(pro_name)
  
