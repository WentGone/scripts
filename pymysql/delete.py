#!/usr/bin/env python3
import pymysql

conn = pymysql.connect(
    host = '127.0.0.1',
    port = 3306,
    user = 'root',
    password = '123456',
    db = 'live',
    charset = 'utf8'
)

cursor = conn.cursor()

sql = 'delete from grade'
res = cursor.execute(sql)

conn.commit()
cursor.close()
conn.close()
