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
@                                   |-应用于innodb表

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
过滤结果：
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
            |
            |-限制行号    --|-limit

--------------------------------------------------------------------------------------------------------
MySQL存储引擎：InnoDB MRG_MYISAM MEMORY BLACKHOLE MyISAM CSV ARCHIVE PERFORMANCE_SCHEMA FEDERATED





                                    |-frm文件---表结构
                        |-存储结构--|-MYI文件---索引信息
                        |           |-MYD文件---数据
                        |
                        |           |-不支持外键
                        |-功能    --|-不支持事务
                        |           |-不支持事务回滚
            |-MYISAM  --|
            |           |-锁      --|-表级锁
            |           |
            |           |-应用    --|-查询操作多的表，直接锁整张表，节约CPU资源
常用引擎  --|
            |                       |-frm文件---表结构
            |           |-存储结构--|           |-数据
            |           |           |-ibd文件---|
            |           |                       |-索引信息
            |           |   
            |           |           |-支持外键
            |           |-功能    --|-支持事务
            |-INNODB  --|           |-支持事务回滚
                        |
                        |-锁      --|-行级锁
                        |
                        |-应用    --|-写操作多的表，降低并发写入磁盘的等待时间


                                    |-行级锁-一行数据
                         |-锁粒度 --|-表级锁-整张表
                         |          |-页级锁-内存里1M的数据
锁：解决并发访问冲突问题-|
                         |          |-读锁--|-select  --|-共享锁
                         |-锁类型 --|
                                    |       |-insert  --|
                                    |-写锁--|-update  --|-排他锁
                                            |-delete  --|


事务    ：一次sql操作从开始到结尾的过程
事务回滚：在事务执行过程中，任意一步操作失败，恢复之前所有的操作
事务日志：记录所有的sql操作

            |-原子性：事务的整个操作是一个整体，不可分割，要么成功，要么失败
            |-一致性：事务操作的前后，表中记录没有变化
事务特性  --|
            |-隔离性：事务的操作是相互隔离不受影响的
            |-永久性：数据一旦提交，不可改变，永久性的改变数据

事务是一个过程，有时间线的，MySQL默认开启自动提交，关闭自动提交后可以查看事务执行过程

            |-ib_logfile0 --|
            |               |-已经提交的sql命令
事务日志  --|-ib_logfile1 --|
            |
            |               |-未提交的sql命令（可以回滚）
            |-ibdata1     --|
                            |-LSN日志序列号
                            
-----------------------------------------------------------------------------------------

复制表的操作以后不会复制源表的索引
复制表结构的原理是在查询源表的时候加一个永假条件create table db2.t1 select * from db1.t1 where 1=2;

--------------------------------------------------------------------------------------------------

数据库备份

        |-策略     -|-完整（周、月）、增量（日、时）
        |-时间     -|-晚上（服务器压力小，读写频率低）
备份问题|-频率     -|-根据数据量
        |-文件名   -|-日期、时间
        |-存储空间 -|-可扩展（raid、lvm）


                    |-cp   -|
        |-物理备份--|-zip  -|-直接处理磁盘文件--|-小量数据，myisam存储引擎
        |           |-tar  -|
备份方式|
        |           |mysqldump -|
        |-逻辑备份--|           |-做备份时将创建库、表、操作数据的sql命令存储到一个文件中
                    |mysql     -|


                                |-all      -|
        |-所有数据--|-完整备份--|-one db   -|-mysqldump、mysql
        |                       |-one table-|
备份策略|
        |                                       |-节约空间，速度快         -|
        |           |-增量备份--|-参照上次备份--|                           |-binlog日志、innobackupex
        |           |                           |-冗余性差，丢失一个则完蛋 -|
        |-新增数据--|
                    |                           |-冗余性好，仅剩余最近一次备份即可
                    |-差异备份--|-参照完整备份--|
                                                |-浪费存储空间，数据量大的时候耗时
        
       
binlog日志：记录除查询操作外的sql命令的二进制日志

            |-statement-|-每条修改数据的sql命令都会记录
binlog日志--|-row      -|-不记录sql语句的上下文信息
            |-mixed    -|-混合使用





注：1、innodb引擎不适合物理备份，因为innodb引擎存储对数据处理分为数据和事务日志两部分，只备份数据有可能会
造成事务日志紊乱的情况
    2、生产环境下备份数据的方法是计划任务+脚本、搭建MySQL主从同步
    3、生产环境最常用的是完整备份+增量备份
    4、为什么有时候设置了binlog日志的大小不管用，因为在处理大事务的时候所有日志会写入到同一个binlog日志中