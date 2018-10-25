MySQL数据库复习记录点

RDBMS--> relationship database manager system

列出库：show databases;
切换库：use database;
列出当前库的表：show tables;

创建库：create database dbname;
删除库：drop database dbname;

创建表：create table tbname(
字段 数据类型（约束宽度） 约束条件，
字段 数据类型（约束宽度） 约束条件，
字段 数据类型（约束宽度） 约束条件，
);
删除表：drop table tbname;

删除表中的所有数据：delete from tbname;
写入数据：insert into tbname([字段名]) values (value1),(value2)...;
更新数据：update tbname set 字段名='value' where 条件;

修改表结构：
增加字段：alter table tbname add 字段1 数据类型（约束宽度） 约束条件，add 字段2 数据类型（宽度） 约束条件..;
增加在第一列：alter table tbname add 字段1 数据类型（宽度） 约束条件 first;
增加在指定位置：alter table tbname add 字段1 数据类型（宽度） 约束条件 after 指定字段;
修改已有字段名：alter table tbname change 原字段名 新字段名 数据类型（宽度） 约束条件;
修改已有字段约束：alter table tbname modify 字段名 新约束条件;

#change和modify，修改已有字段名的时候必须要用change，modify报语法错误，如果是修改已有字段的约束条件
则change和modify的功能一样，语法上change多了一个保留的列名，故默认修改字段名时用change，修改约束条件
时用modify


