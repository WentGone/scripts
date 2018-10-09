#!/usr/bin/env python3
#--coding: utf8--
import sys

cost = int(input('请输入营业额（万元）: '))
if cost <= 0:
    print('营业额必须是正数')
    sys.exit()
elif 0 < cost <= 10:
    profit = cost * 0.1
elif 10 < cost <= 20:
    profit = (cost - 10) * 0.075 + 10 * 0.1
elif 20 < cost <= 40:
    profit = (cost - 20) * 0.05 + 10 * 0.075 + 10 * 0.1
elif 40 < cost <= 60:
    profit = (cost - 40) * 0.03 + 20 * 0.05 + 10 * 0.075 + 10 * 0.1
elif 60 < cost <= 100:
    profit = (cost - 60) * 0.015 + 20 * 0.03 + 20 * 0.05 + 10 * 0.075 + 10 * 0.1
elif cost > 100:
    profit = (cost - 100) * 0.01 + 40 * 0.015 + 20 * 0.03 + 20 * 0.05 + 10 * 0.075 + 10 * 0.1
print('利润是%s元' % int(profit * 10000))
