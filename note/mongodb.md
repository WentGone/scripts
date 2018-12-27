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
        |           |       |-一主一从
        |           |-结构 -|
        |           |       |-一主多从
        |           |
        |           |       |-至少需要两个节点，一个主节点，一个从节点，主节点负责处理客户端请求，从节点复制主节点数据
        |           |-原理 -|-副本集也是主节点挂掉以后从节点投票的机制，所以要保证活跃节点数超过半数
        |           |       |-主节点记录所有的oplog，从节点定期轮询主节点获取操作记录，然后对自己的数据副本执行同样操作，保证数据一致性
        |           |
        |           |                                   |-启动一台加上-master参数，作为主节点
        |           |           |-master-slave主从复制 -|-启动其他加上-slave和-source参数，作为从节点
        |           |           |                       |       |-从节点可以提供数据查询，降低主节点的访问压力
        |           |           |                       |-特点 -|-由从节点执行备份，避免锁定主节点数据
        |           |           |                               |-当主节点故障时，可以快速切换到从节点，实现高可用
        |-副本集   -|-实现方式 -|
        |           |           |               |-支持故障自动切换，自动修复成员节点，降低运维成本
        |           |           |-Replica Sets -|
        |           |                           |-副本集的结构类似于高可用集群
        |           |
        |           |       |-配置文件加入replSet，启动服务，config = {_id:'rsname',members:[_id:0,host:'host:port'...]}/rs.initiate(config)
        |           |-配置 -|-rs.status()查看集群状态
        |           |       |-rs.add()/rs.remove()增加/踢出节点
        |
        |                               |-集合不存在时创建集合，然后插入记录
        |                   |-save({}) -|-_id字段值已存在时修改文档字段的值
        |                   |           |-_id字段值不存在时插入文档
        |                   |
        |                   |            |-集合不存在时创建集合，然后插入记录
        |           |-插入 -|-insert({})-|-_id字段值已存在时放弃插入
        |           |       |            |-_id字段值不存在时插入文档
        |           |       |
        |           |       |-insertMany([{},{}])  -|-一次写入多条
        |           |
        |           |       |-fineOne()-|-显示匹配结果的第一条
        |           |-查询 -|
        |           |       |           |-默认输出20行，键入it继续查看
        |           |       |           |-({条件},{定义显示的字段}) //0不显示，1显示
        |           |       |           |
        |           |       |           |           |-limit(数字)   //显示的行数
        |           |       |           |-行数限制 -|-skip(数字)    //跳过前几行
        |           |       |-find()   -|           |-sort(字段名)  //1是升序，-1是降序
        |           |                   |
        |           |                   |                       |-({key:value})
        |           |                   |           |-简单条件 -|
        |           |                   |           |           |-({key:value},{key:value})     //逻辑与
        |           |                   |           |
        |           |                   |           |           |-$in   ({uid:{$in:[1,6,9]}})       //在..里
        |           |                   |           |-范围比较 -|-$nin  ({uid:{$nin:[1,6,9]}})    //不在..里
        |           |                   |           |           |-$or   ({$or:[{name:'root'},{uid:1}]})    //或
        |           |                   |           |
        |           |                   |-条件匹配 -|-正则     -|-({name:/^a/})             //正则表达式置于//之间
        |           |                               |
        |           |                               |           |-$lt   //小于     -|
        |           |                               |           |-$lte  //小于等于 -|-({uid:{$gt:10,$lt:40}})   //逻辑与
        |           |                               |-数值比较 -|-$gt   //大于     -|
        |           |                               |           |-$gte  //大于等于 -|-({uid:{$lt:5}})
        |           |                               |           |-$ne   //不等于   -|
        |           |                               |
        |           |                               |-匹配null -|-({name:null})
        |-文档管理 -|
                    |-更新
                    |-删除