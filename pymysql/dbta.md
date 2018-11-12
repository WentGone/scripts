create database live;
use live;
create table student (id int(2) primary key, name char(10), class char(15));
create table grade (id int(2), object char(10), grade int(2));

#导入模块
import pymysql
#创建连接
conn = pymysql.connect(host='',port=,user='',password='',db='',charset='utf8')
#创建游标
cursor = conn.cousor()
#定义sql
sql = 'sql语句'
#执行sql命令
res = cursor.execute(sql)
#提交到磁盘
conn.commit()
#关闭连接
cursor.close()
conn.close()
