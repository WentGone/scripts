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

sql_select = 'select * from student order by id'
cursor.execute(sql_select)

#res1 = cursor.fetchone()
#print(res1)

#res2 = cursor.fetchmany(2)
#print(res2)

res3 = cursor.fetchall()
print(res3)

cursor.close()
conn.close()
