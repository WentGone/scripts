#!/bin/bash
#AUTHOR:AN
#DATE:2019-04-21
#FUNCTION:屏幕显示倒计时
#DESCRIBE:模拟单片机中数码管的数字显示形状，先把0~9中的每个数字造出来
#         通过echo命名的不换行功能，将三列数字同时输出，每个数字分成9行
#         通过for循环每次输出一行内容
#PEOBLEM:如何在计时结束后按Ctrl+c退出，且显示光标

#显示8个红色空格
red(){
for i in `seq $1`
do
        echo -e "\033[41m \033[0m\c"
done
}
#显示8个白色空格
white(){
for i in `seq $1`
do
        echo -e "\033[8m \033[0m\c"
done
}

#组成数字的元素
YS[0]=`red 1;white 6;red 1;white 8`     #1 1
YS[1]=`white 7;red 1;white 8`           #右1
YS[2]=`red 1;white 7;white 8`           #左1
YS[3]=`red 8;white 8`                   #-
YS[4]=`white 8;white 8;white 8`         #控制左边留出空白

##############################################################
#将0~9的所有数字一次存入数组NUM中
#0
NUM[0]=`echo ${YS[3]}`  
NUM[1]=`echo ${YS[0]}` 
NUM[2]=`echo ${YS[0]}`
NUM[3]=`echo ${YS[0]}`
NUM[4]=`echo ${YS[0]}`
NUM[5]=`echo ${YS[0]}`
NUM[6]=`echo ${YS[0]}`
NUM[7]=`echo ${YS[0]}`
NUM[8]=`echo ${YS[3]}`

#1
NUM[9]=`echo ${YS[1]}`  
NUM[10]=`echo ${YS[1]}`
NUM[11]=`echo ${YS[1]}`
NUM[12]=`echo ${YS[1]}`
NUM[13]=`echo ${YS[1]}`
NUM[14]=`echo ${YS[1]}`
NUM[15]=`echo ${YS[1]}`
NUM[16]=`echo ${YS[1]}`
NUM[17]=`echo ${YS[1]}`

#2
NUM[18]=`echo ${YS[3]}`
NUM[19]=`echo ${YS[1]}`
NUM[20]=`echo ${YS[1]}`
NUM[21]=`echo ${YS[1]}`
NUM[22]=`echo ${YS[3]}`
NUM[23]=`echo ${YS[2]}`
NUM[24]=`echo ${YS[2]}`
NUM[25]=`echo ${YS[2]}`
NUM[26]=`echo ${YS[3]}`

#3
NUM[27]=`echo ${YS[3]}`
NUM[28]=`echo ${YS[1]}`
NUM[29]=`echo ${YS[1]}`
NUM[30]=`echo ${YS[1]}`
NUM[31]=`echo ${YS[3]}`
NUM[32]=`echo ${YS[1]}`
NUM[33]=`echo ${YS[1]}`
NUM[34]=`echo ${YS[1]}`
NUM[35]=`echo ${YS[3]}`

#4
NUM[36]=`echo ${YS[0]}`
NUM[37]=`echo ${YS[0]}`
NUM[38]=`echo ${YS[0]}`
NUM[39]=`echo ${YS[0]}`
NUM[40]=`echo ${YS[3]}`
NUM[41]=`echo ${YS[1]}`
NUM[42]=`echo ${YS[1]}`
NUM[43]=`echo ${YS[1]}`
NUM[44]=`echo ${YS[1]}`
#5
NUM[45]=`echo ${YS[3]}`
NUM[46]=`echo ${YS[2]}`
NUM[47]=`echo ${YS[2]}`
NUM[48]=`echo ${YS[2]}`
NUM[49]=`echo ${YS[3]}`
NUM[50]=`echo ${YS[1]}`
NUM[51]=`echo ${YS[1]}`
NUM[52]=`echo ${YS[1]}`
NUM[53]=`echo ${YS[3]}`
#6
NUM[54]=`echo ${YS[3]}`
NUM[55]=`echo ${YS[2]}`
NUM[56]=`echo ${YS[2]}`
NUM[57]=`echo ${YS[2]}`
NUM[58]=`echo ${YS[3]}`
NUM[59]=`echo ${YS[0]}`
NUM[60]=`echo ${YS[0]}`
NUM[61]=`echo ${YS[0]}`
NUM[62]=`echo ${YS[3]}`
#7
NUM[63]=`echo ${YS[3]}`
NUM[64]=`echo ${YS[0]}`
NUM[65]=`echo ${YS[0]}`
NUM[66]=`echo ${YS[0]}`
NUM[67]=`echo ${YS[1]}`
NUM[68]=`echo ${YS[1]}`
NUM[69]=`echo ${YS[1]}`
NUM[70]=`echo ${YS[1]}`
NUM[71]=`echo ${YS[1]}`
#8
NUM[72]=`echo ${YS[3]}`
NUM[73]=`echo ${YS[0]}`
NUM[74]=`echo ${YS[0]}`
NUM[75]=`echo ${YS[0]}`
NUM[76]=`echo ${YS[3]}`
NUM[77]=`echo ${YS[0]}`
NUM[78]=`echo ${YS[0]}`
NUM[79]=`echo ${YS[0]}`
NUM[80]=`echo ${YS[3]}`
#9
NUM[81]=`echo ${YS[3]}`
NUM[82]=`echo ${YS[0]}`
NUM[83]=`echo ${YS[0]}`
NUM[84]=`echo ${YS[0]}`
NUM[85]=`echo ${YS[3]}`
NUM[86]=`echo ${YS[1]}`
NUM[87]=`echo ${YS[1]}`
NUM[88]=`echo ${YS[1]}`
NUM[89]=`echo ${YS[3]}`

#读取位置变量分钟，并转化为秒
display(){
time=$[ $1 * 60 ]
while [ $time -ge 0 ]
do
    #数值处理
    ge=$[time%100%10*9]
    shi=$[time%100/10*9]
    bai=$[time/100*9]
    clear
    #输出空白行，是数字居中
    for i in {0..6}
    do
        echo
    done
    for i in {0..8}
    do          
        echo ${YS[4]}${NUM[$[bai+i]]}${NUM[$[shi+i]]}${NUM[$[ge+i]]}        
    done    
    sleep 1 
    let time--
done
sleep 2
echo
echo
echo -e "\033[?25h"     #显示光标
}

#############################主程序#############################
clear
echo -e "\033[?25l"     #隐藏光标
if [ $# -ne 1 ];then
    echo "You Must Input a timestate"
else
    display $1
fi
