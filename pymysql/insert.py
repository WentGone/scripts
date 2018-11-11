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

##插入一条数据
sql_insert1 = 'insert into student values (%s, %s, %s)'
result = cursor.execute(sql_insert1,(1001, '张三', '三年一班'))

sql_insert2 = 'insert into student values (%s, %s, %s)'
students = [
    (1002, '李四', '三年二班'),
    (1003, '王五', '三年三班')
]
result = cursor.executemany(sql_insert2, students)

sql_insert3 = 'insert into grade values (%s, %s, %s)'
grades = [
    (1001, '数学', 100),
    (1002, '数学', 46),
    (1003, '数学', 84),
    (1001, '语文', 93),
    (1002, '语文', 62),
    (1003, '语文', 73),
    (1001, '外语', 98),
    (1002, '外语', 80),
    (1003, '外语', 55), 
]
result = cursor.executemany(sql_insert3, grades)

conn.commit()
cursor.close()
conn.close
