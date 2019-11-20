#!/bin/bash
# Author:   Mark Li
# Date:     2019-11-20
# Desc:     字幕式显示文件内容
# Version： 1.0

if [ $# -eq 0 ];then
    echo "没有指定文件，请重新指定文件" | pv -qL 20
else
    for i in $@
    do
        if [ ! -e $i ];then
            echo "指定文件不存在，跳过" | pv -qL 20
            continue
        else
            cat $i | pv -qL 20
        fi
    done
fi
