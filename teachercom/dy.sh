#!/bin/bash

for i in node0{1..2}
do
    #关闭虚拟机
    virsh destroy ${i}
    #快照到初始状态
    virsh snapshot-revert $i ${i}-dynamic
    #启动虚拟机
    virsh start ${i}
done
