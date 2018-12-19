MongoDB学习笔记
                |-介于关系型数据库和非关系型数据库的中间产品
                |-一款基于分布式文件存储的数据库，旨在为web应用提供可扩展的高性能数据存储解决方案
        |-简介 -|-将数据存储为一个文档（类似于json对象），数据结构由键值对组成
        |       |-支持丰富的查询表达，可以设置任何属性的索引
        |       |-支持副本集、分片
        |
        |       |-命令严格区分大小写
        |       |-默认监听127.0.0.1:27017
        |-特性 -|-bind_ip;bind_ip_all;port
        |       |-连接：--host --port -u -p
        |
        |           |-admin    -|-MongoDB的用户、角色信息
MongoDB-|-默认库   -|-local    -|-副本集的元数据
        |           |-config   -|-服务配置信息及运行信息
        |-use是延时创建库，use以后不会马上建库，操作一次以后才会创建库
        |
        |           |-字符串string -|-utf-8字符串都可以表示为字符串数据类型
        |           |-布尔bool     -|-true和false
        |           |-空null       -|-表示空值或者字段不存在
        |           |
        |           |       |-shell默认使用64位浮点型数值
        |           |-数值 -|-NumberInt（4字节整数）
        |           |       |-NumberLong（8字节整数）
        |           |
        |           |-数组array-|-数据列表或者数据集可以表示为数组
        |-数据类型 -|
        |           |-代码 -|-查询和文档中可以报错任何JS代码   -|-{x:function(){/*代码*/}}
        |           |-日期 -|-日期被存储为自新纪元以来经过的毫秒数，不含时区
        |           |-对象 -|-对象id是一个12字节的字符串，是文档的唯一标识，类似于MySQL的主键
        |           |-内嵌 -|-文档可以嵌套其他文档，被嵌套的文档作为值来处理
        |           |-正则表达式   -|-查询时使用正则表达式作为限定条件 -|-{x:/正则表达式/}
        |       
        |                           |-导入数据时，若库和集合不存在，则先创建库和集合再导入数据(不用手动创建)
        |                   |-规则 -|-若库和集合已经存在，则以追加的方式导入数据到集合里
        |                   |       |-使用--drop选项可以删除原数据后导入新数据，--headline忽略标题
        |           |-导入 -|
        |           |       |       |-mongoimport --host ip --port port -d 库名 -c 集合名 --type=json 目录/文件名.json
        |           |       |-格式 -|
        |           |               |-mongoimport --host ip --port port -d 库名 -c 集合名 --type=csv [--headerline --drop] 目录/文件名.csv
        |-导入导出 -|
        |           |       |-csv格式必须用-f指定字段名
        |           |       |-mongoexport [--host ip --port port] -d 库名 -c 集合名 -f 字段1，字段2 --type=csv > 目录/文件名.csv
        |           |-导出 -|-mongoexport [--host ip --port port] -d 库名 -c 集合名 -q '{条件}' -f 字段1，字段2 --type=csv > 目录/文件.csv
        |                   |-mongoexport [--host ip --port port] -d 库名 -c 集合名 [-q '{条件}' -f 字段列表] --type=json > 目录、文件.json
        |   
        |                   |-mongodump [--host ip --port port] 备份所有库到当前目录下的dump目录下
        |           |-备份 -|
        |           |       |-mongodump [--host ip --port port] -d 库名 -c 集合名 -o 目录
        |           |
        |-备份还原 -|-查看 -|-bsondump ./dump/bbs/t1.bson
        |           |-还原 -|-mongorestore --host ip --port port -d 库名 [-c 集合名] 备份目录名
        |
        |                   |-MongoDB复制
        |           |-介绍 -|-指在多个服务器上存储副本，并实现数据同步
        |           |       |-提高数据可用性、安全性，方便数据故障恢复
        |           |
        |-副本集   -|
