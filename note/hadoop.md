大数据定义：大数据有巨星数据集组成，这些数据集大小超出人类在可接受时间下的收集、使用、管理和处理的能力
-----------------------------------------------------------------------------------------------------
                            |-TB级别   -|
                            |-记录/日志-|
            |-Volume(数量) -|           |-即可从数百TB到数百PB,甚至是EB的规模
            |               |-事务     -|
            |               |-表&文件  -|
            |
            |                   |-批量处理 -|
            |                   |-实时     -|
            |-Velocity(速度)   -|           |-大数据需要在一定的时间限度下及时处理
            |                   |-多进程   -|
            |                   |-数据流   -|
            |
            |               |-结构化   -|
            |               |-非结构化 -|
大数据特性 -|-Variety(种类)-|           |-大数据包括各种格式和形态的数据
            |               |-多因素   -|
            |               |-概率性   -|
            |
            |                   |-可信性   -|
            |                   |-真伪性   -|
            |-Veracity(真实性) -|-来源&信誉-|-处理的结果要保证一定的准确性
            |                   |-有效性   -|
            |               |-统计学   -|
            |               |-事件性   -|
            |-Value(价值)  -|           |-大数据包含很多深度的价值,数据分析挖掘将带来巨大的价值
                            |-相关性   -|
                            |-假设性   -|
------------------------------------------------------------------------------------------------
                    
开源的Hadoop性能比谷歌的三大技术要差很多
                    |-GFS      -|-分布式文件系统
                    |                                               |-Map是映射，把指令分发到多个worker上去
        |-Google   -|-MapReduce-|-针对分布式并行计算的一套编程模型 -|
        |           |                                               |-Reduce是规约，把多个worker计算的结果合并
        |           |   
        |           |-BigTable -|-存储结构化数据，多维稀疏图
起源   -|
        |           |-HDFS
        |-Hadoop   -|-MapReduce
                    |-Hbase
-----------------------------------------------------------------------------------------------------------------

Hadoop详解：
                |-分析和处理海量数据的软件平台
        |-定义 -|-开源软件,使用Java开发
        |       |-可以提供一个分布式基础架构
        |
        |       |-高可用性
        |       |-高扩展性
        |-特点 -|-高效性
        |       |-高容错性
        |       |-低成本
        |
        |           |-HDFS     -|-分布式文件系统
        |-核心组件 -|-MapReduce-|-分布式计算框架
        |           |-YARN     -|-集群资源管理系统
        |
        |           |-HDFS：分布式文件系统
        |           |-MapReduce：分布式计算框架
        |           |-Zookeeper：分布式协作服务
        |           |-Hbase：分布式阵列数据库
        |-常用组件 -|-Hive：基于Hadoop的数据仓库
        |           |-Sqoop：数据同步工具
        |           |-Pig：基于Hadoop的数据流系统
        |           |-Mahout：数据挖掘算法库
        |           |-Flume：日志收集工具
Hadoop -|
        |       |-是Hadoop体系中数据存储管理的基础，高容错的系统，运行于低成本的硬件上
        |-HDFS -|
        |       |                   |-切分文件：按照block缺省值切分需要存储的数据
        |       |                   |-访问HDFS
        |       |       |-Client   -|
        |       |       |           |-与Namenode交互，获取文件存储位置信息
        |       |       |           |-与DataNode交互，读取和写入数据
        |       |       |
        |       |       |-Namenode     -|-Master节点，管理HDFS的名称空间和数据库映射信息，配置副本策略，处理所有客户端请求
        |       |       |
        |       |-组件 -|-Block-|-每块缺省64MB大小，可以多个副本
        |               |
        |               |                                                           |-fsimage：数据存储日志
        |               |               |-定期合并fsimage和fsedits，推送给Namenode -|
        |               |               |                                           |-fsedits：数据变更日志
        |               |-Secondarynode-|-紧急情况下，可辅助恢复Namenode
        |               |               |-{并非Namenode的热备份节点，仅仅是辅助功能}
        |               |
        |               |           |-数据存储节点，存储实际数据
        |               |-Datanode -|
        |                           |-回报存储信息给Namenode
        |
        |           |-源于谷歌的MapReduce论文，Java实现的分布式计算框架
        |-MapReduce-|
        |           |                       |-Master节点，只有一个
        |           |                       |-管理所有作业
        |           |       |-JobTracker   -|
        |           |       |               |-作业/任务的监控、错误处理等
        |           |       |               |-将任务分解成一系列任务，并分派给TaskTracker
        |           |-组件 -|
        |                   |               |-Slave节点，一般是多台         
        |                   |-TaskTracker  -|-运行MapTask和ReduceTask       
        |                                   |-与JobTracker交互并回报任务状态
        |                                   |       |-MapTask：解析每条数据记录，传递给用户编写的map()并将输出结果写入本地磁盘
        |                                   |-分支 -|               |-从MapTask的执行结果中远程读取输入数据，对数据进行排序
        |                                           |-ReduceTask   -|
        |                                                           |-将数据按照非分组传递给用户编写的reduce()执行
        |
        |       |-是Hadoop的一个通用的资源管理系统
        |       |-核心思想是将JobTracker和TaskTracker进行分离
        |-YARN -|
                |                           |-处理客户端请求
                |                           |-启动/监控ApplicationMaster
                |       |-ResourceManager  -|
                |       |                   |-监控NodeManager
                |       |                   |-资源分配调度
                |       |
                |       |               |-单个节点上的资源管理
                |       |-NodeManager  -|-处理来自ResourceManager的命令
                |       |               |-处理来自ApplicationMaster的命令
                |-组件 -|
                        |           |-对任务的运行环境的抽象，封装了CPU、内存等
                        |-Container-|
                        |           |-多维资源以及环境变量、启动命令等任务运行相关的信息资源分配与调度
                        |
                        |                   |-数据切分
                        |-ApplicationMaster-|-为应用程序申请资源，并分配给内部任务
                        |                   |-任务监控与容错
                        |
                        |           |-用户与Yarn交互的客户端程序
                        |-Client   -|
                                    |-提交应用程序、监控应用程序状态、杀死应用程序等
-------------------------------------------------------------------------------------------------------------------------------------------

完全分布式集群：


            |-软件目录 
            |-/usr/local/hadoop/
            |
            |                                               |-JAVA_HOME：openjdk的安装目录
            |                               |-hadoop-env.sh-|
            |                               |               |-HADOOP_CONF_DIR：hadoop配置文件路径
            |                               |        
            |                               |                       |-fs.defaultFS：默认文件系统
            |                               |       |-core-site.xml-|
            |                               |       |               |-hadoop.tmp.dir：文件存储位置
            |                               |       |       
            |                               |       |               |-dfs.namenode.http-address：namenode地址
完全分布式 -|-配置文件路径                 -|-HDFS -|-hdfs-site.xml-|-dfs.namenode.secondary.http-address：secondarynamenode地址
            |-/usr/local/hadoop/etc/hadoop  |       |               |-dfs.replication：存储文件副本数
            |                               |       |       
            |                               |       |-slaves   -|-标识出所有的datanode主机名
            |                               |
            |                               |-MapReduce-|-mapred-site.xml  -|-mapreduce.framework.name：定义资源管理类(local|yarn)
            |                               |
            |                               |                       |-yarn.resourcemanager.hostname：指定resourcemanager节点主机名
            |                               |-YARN -|-yarn-site.xml-|
            |                                                       |-yarn.nodemanager.aux-services：指定计算节点采用的mr算法名
            |
            |                                   |-总脚本，可调用hdfs和yarn的脚本
            |                                   |-hadoop version
            |                       |-hadoop   -|-hadoop jar jar包路径
            |                       |           |-hadoop fs :以hdfs的客户端身份运行，直接回车提示出来的命令均可用
            |                       |        
            |                       |       |-hdfs namenode -format：初始化namenode
            |                       |       |-hdfs dfsadmin -report：检查hdfs集群状态
            |-工具路径             -|-hdfs -|
            |-/usr/local/hadoop/bin |       |-hdfs dfsadmin -setBalancerBandwidth：设置平衡数据带宽
            |                       |       |-hdfs dfsadmin -refreshNodes：迁移需要下线节点的数据
            |                       |       
            |                       |-yarn -|-yarn node -list：检查yarn集群状态
            |               
            |                                   |-start-all.sh：启动所有服务(hdfs&yarn)
            |                           |-all  -|   
            |                           |       |-stop-all.sh：停止所有服务
            |                           |
            |                           |       |-start-dfs.sh：启动hdfs服务
            |                           |       |-stop-dfs.sh：停止hdfs服务
            |-服务路径                 -|-hdfs -|-hadoop-daemon.sh start|stop datanode：控制datanode服务       
            |-/usr/local/hadoop/sbin    |       |-start-balancer.sh：启动平衡数据服务
            |                           |       |-stop-balancer.sh：关闭平衡数据服务
            |                           |
            |                           |       |-start-yarn.sh：启动yarn服务
            |                           |       |-stop-yarn.sh：停止yarn服务
            |                           |-yarn -|
            |                                   |-yarn-daemon.sh start|stop nodemanager：启停nodemanager服务
            |
            |               |-namenode -|-/var/hadoop/dfs/name
            |-数据路径     -|-secondarynamenode-|-/var/hadoop/dfs/namesecondary
            |-/var/hadoop   |-datanode -|-/var/hadoop/dfs/data
            |
            |           |-http://namenode:50070            -|-namenode管理页面         -|
            |           |-http://secondarynamenode:50090   -|-secondarynamenode管理页面-|           |namenode/secondarynamenode/resourcemanger
            |-页面管理 -|-http://resourcemange:8088        -|-resourcemanager管理页面  -|-注意角色 -|
            |           |-http://datanode:50075            -|-datanode管理页面         -|           |datanode/nodemanager
            |           |-http://nodemanager:8042          -|-nodemanager管理页面      -|
            |
            |                           |-配置环境、安装java
            |                           |-复制namenode配置文件到配置文件目录下
            |                           |-修改namenode的slaves文件
            |                   |-增加 -|-启动该节点的datanode
            |                   |       |-设置同步带宽
            |                   |       |-查看hdfs集群状态
            |                   |       
            |                   |       |-配置需要删除的节点
            |                   |       |                       |-Normal    正常
            |           |-hdfs -|-删除 -|-迁移数据 -|-节点状态 -|-Decommissioned in Program 数据库正在迁移
            |           |-(数据)|       |                       |-Decommissioned    数据迁移完成（此状态下才能下线节点）
            |           |       |       |-完成数据迁移以后停止该节点的datanode服务
            |           |       |
            |           |       |       |-与添加节点步骤基本一致
            |           |       |       |-替换节点的ip和主机名与损坏节点一致
            |           |       |-修复 -|-启动服务  datanode
            |           |               |-自动恢复数据
            |           |               |-恢复时间与数据量成正比
            |-节点管理 -|
            |           |       |-增加 -|-启动NodeManager服务
            |           |-yarn -|
            |                   |-删除 -|-关闭NodeManager服务
            |
            |           |-组建一台机器，作为hdfs客户端和nfs服务的结合体，cli可以通过挂载nfs的方式访问hdfs集群，仅支持nfsv3
            |           |
            |           |       |-不支持随机写入，顺序写入
            |-NFS网关  -|-特性 -|-在非安全模式下，运行网关的用户是代理用户
                        |       |-安全模式下，Kerberos keytabs中的用户是代理用户
                        |       |-保证nfsgw的代理用户和namenode上的用户名、uid、gid必须一致
                        |
                        |       |-配置nfsgw的hosts，通联namenode和所有datanode
                        |       |-添加代理用户，nfsgw和namenode保持一致
                        |       |-停止集群
                        |-步骤 -|-修改core-site.xml配置文件
                                |-同步文件
                                |-启动集群
、                              |-查看状态
--------------------------------------------------------------------------------------------------------------------------------------
Zookeeper集群：

    |-开源的分布式应用程序协调服务
    |-用于保证数据在集群间的事物一致性
    |
    |       |-集群分布式锁（共享锁、排他锁）
    |-功能 -|-集群统一命名服务
    |       |-分布式协调服务
    |
    |                                   |-接受所有Follower的提案请求
    |                       |-Leader   -|-统一协调发起提案的投票
    |                       |           |-负责与所有的Follower进行内部的数据交换
    |                       |
    |                       |           |-直接为客户端服务
    |               |-角色 -|-Follower -|-参与提案投票
    |               |       |           |-与Leader进行数据交换
    |               |       |
    |               |       |           |-直接为客户端服务
    |               |       |-Observer -|-不参与提案的投票
    |               |                   |-与Leader进行数据交换
    |               |
    |               |       |-服务启动时没有角色（looking）
    |               |       |-通过选举产生
    |               |       |-选举产生一个Leader，剩下的是Follower
zk -|-角色与特性   -|-选举 -|-超过半数投票才能成为Leader
    |               |       |-m>=n/2+1
    |               |       |-Follower死机过多，剩余机器不到半数加一，集群崩溃
    |               |       |-Observer不计算在投票设备的总数里





















