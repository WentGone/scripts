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

索引
优点：加快查询速度
缺点：减慢写入速度，占用磁盘空间


                                    |-一个表中可以有多个index字段
                                    |-字段的值允许重复，且可以赋NULL值
         |--INDEX       --普通索引--|
         |                          |-把常作为查询条件的字段做成index索引
         |                          |-KEY标志是MUL
         |
         |                          |-一个表中可以有多个unique字段
         |                          |-字段的值不允许重复，但可以赋NULL值
         |--UNIQUE      --唯一索引--|
         |                          |-把常作为查询条件的字段做成unique索引
         |                          |-KEY标志是UNI
         |
         |                          |-仅应用于myisam表
键值类型-|--FULLTEXT    --全文索引--|-用于全文搜索，一般使用Sphinx替代
         |                          |-可以提高全文搜索的效率
         |
         |                          |-提高查询效率，且提供唯一性约束
         |                          |-一张表中只能有一个主键，KEY标志是PRI
         |--PRIMARY KEY --主键    --|-一般与auto_increment连用，被标记自增的一定是主键，但主键不一定自增
         |                          |-字段值不能重复且不能为空，一般放在无意义的字段
         |                          |-主键的类型最好是数值
         |                          
         |                          |-提高查询效率
         |                          |-对应其他表的主键
         |--FOREIGN KEY --外键    --|-KEY标志是MUL
                                    |-外键的效率不好，但用的是保持数据一致性的思想
                                    |-应用于innodb表
---------------------------------------------------------------------------------------------------------

查询条件：

            |-数字类型:= != > >= < <=
            |
            |           |- = !=（符号右边需要用双引号括起来）
            |-字符类型--|
            |           |-is null ; is not null(空和非空)
            |
            |           |-and 与
            |           |-or  或
基础条件  --|-逻辑比较--|
            |           |-not ！非
            |           |-()提高优先级
            |
            |           |-in、not in
            |-范围内  --|-between..and..
                        |-distinct （去掉重复） select distinct name from stu_table

                            |-_匹配单个字符
            |-模糊匹配(字符)|
            |               |-%匹配0个或多个字符(%可以匹配空白字符,但是不能匹配null)
            |
            |               |-^ -|
            |               |-$ -|  
            |-正则表达式  --|-. -|--正则元字符
高级条件  --|               |-[]-|
            |               |-* -|
            |
            |               |-+-*/(加减乘除)
            |-四则运算(数字)|
                            |-%(取余)
           
--------------------------------------------------------------------------------------------------------
                            |-avg()
                            |-sum()
            |-聚集函数    --|-min()
            |               |-max()
            |               |-count()
            |
            |-排序        --|-order by 字段名 asc|desc
查询结果操作|
            |-分组        --|-group by 字段名
            |
            |-过滤        --|-HAVING 条件表达式
