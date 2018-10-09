#!/bin/bash
#author: Mark Li
#date: 20180724
#desc:将数据库的某一个新增的内容提取出来放到另外一个表中
#使用要求：原始库和目标库表结构一致，如果不一致，请调整脚本中select *这一行，将*调整为可用字段


org_db=mytest.t5
dst_db=mytest.t7
user=root
passwd=123456
host=localhost

org_lines=`mysql -h${host} -u${user} -p${passwd} -e "select count(*) from ${org_db}"`
org_num=`echo ${org_lines} | awk '{print $2}'`
#echo ${org_num}
dst_lines=`mysql -h${host} -u${user} -p${passwd} -e "select count(*) from ${dst_db}"`
dst_num=`echo ${dst_lines} | awk '{print $2}'`
#echo ${dst_num}
new_lines=`expr ${org_num} - ${dst_num}`
#echo ${new_lines}

bak_db(){
	mysql -h${host} -u ${user} -p${passwd} -e "insert into ${dst_db} select * from ${org_db} limit ${dst_num},${new_lines}"
}

bak_db
if [ $? -eq 0 ];then
	echo "添加成功"
else
	echo "添加失败"
fi
