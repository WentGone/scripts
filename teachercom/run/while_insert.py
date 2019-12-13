#!/usr/bin/env python3
import pymysql
import time
import sys
from random import randint

conn = pymysql.connect(
    host = '192.168.1.1',
    user = 'root',
    password = '123456',
    db = 'mydb',
    port = 3306,
    charset = 'utf8'
)

cursor = conn.cursor()

sql_insert = 'insert into mytb(name,age) values (%s,%s)'

i = 1

while True:
    name = 'name_%s' % i
    age = randint(15,61)
    print("正在写入第\033[32m%s\033[0m条数据" % (i))
    cursor.execute(sql_insert, (name, age))
    if i % 3 == 0:
        try:
            conn.commit()
            time.sleep(1)
        except KeyboardInterrupt:
            print("终止程序")
            sys.exit(0)
    i += 1

cursor.close()
conn.close()
