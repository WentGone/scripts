#!/usr/bin/env python3
import time

date = input('请输入需要查询的日期(如20111111)：')
year = date[0:4]
tra_date = time.strptime(date, '%Y%m%d')
days = tra_date[7]
print('%s这一天是%s年的第%s天' % (date, year, days))
