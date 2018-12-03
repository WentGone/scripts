数据库分类
        |-关系型数据库：MySQL、Oracle、sqlserver、postgresql
数据库 -|
        |-非关系型数据库：Redis、memcache、MongoDB
---------------------------------------------------------------------------------------------------------------------------
Redis数据库
                |-remote directory server
                |-C语言编写，开源软件
        |-介绍 -|-高性能的KV分布式内存数据库
        |       |-支持数据存储化，把数据存放到硬盘
        |       |-支持list、hash、set、zset等类型
        |       |-支持master-slave的数据备份模式
        |
        |       |-默认支持16个数据库，编号0-15
        |       |-key值不能重复，重复即覆盖
Redis  -|-使用 -|-set、get、del、ttl、flushall、type
        |       |-默认数据类型是string
