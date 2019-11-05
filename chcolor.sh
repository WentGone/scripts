#!/bin/bash
#Author: Mark
#Date: 2019.10.28
#Version: 1.0


#exit mask
## exit 2 --> /record file not exist


show_menu(){
    echo -e "\033[41;33m###############################\033[0m"
    echo -e "\033[41;33m#     1:serarch a record      #\033[0m"
    echo -e "\033[41;33m#     2:add a record          #\033[0m"
    echo -e "\033[41;33m#     3:delete a record       #\033[0m"
    echo -e "\033[41;33m#     4:display all record    #\033[0m"
    echo -e "\033[41;33m#     5:edit record with vi   #\033[0m"
    echo -e "\033[41;33m#     H:help screen           #\033[0m"
    echo -e "\033[41;33m#     Q:exit pragrom          #\033[0m"
    echo -e "\033[41;33m###############################\033[0m"
}

search(){
    echo -e "\x1b[37m\x1b[40m";clear
    PS1=''
    while :
    do
    read -p "please enter name >>>" name
    if [ -z "${name}" ];then
        echo "you didn't enter a name"
    else
        result=`cat /record | grep "${name}"`
        if [ -z "$result" ];then
            echo "name not in record"
            sleep 1
        else
            echo "${result}"
            sleep 3
        fi
        break
    fi
    done
    PS1='[\u@\h \W]\$'
    echo -e "\x1b[30m\x1b[49m";clear
}

add(){
    echo -e "\x1b[37m\x1b[40m";clear
    PS1=''
    info1=`echo -e "\033[32menter name and score of a record: \033[0m"`
    read -p "${info1}" nr
    if [ -z "${nr}" ];then
        echo "you didn't enter any value"
        read -p "please enter name and score: " rr
        echo "${rr}" >> /record
        sleep 3
    else
        echo "${nr}" >> /record
        echo "add ${nr} in record"
    fi
    PS1='[\u@\h \W]\$'
    echo -e "\x1b[30m\x1b[49m";clear
}

delete(){
    echo -e "\x1b[37m\x1b[40m";clear
    PS1=''
    info2=`echo -e "\033[32menter name of delete a record: \033[0m"`
    read -p "${info2}" nd
    if [ -z "${nd}" ];then
        echo "you didn't enter name of delete"
        read -p "please enter name of delete: " rd
        sed -ri "/${rd}/d" /record
        echo "delete ${rd} in record"
        sleep 2
    else
        sed -ri "/${nd}/d" /record
        echo "delete ${nd} in record"
        sleep 1
    fi
    PS1='[\u@\h \W]\$'
    echo -e "\x1b[30m\x1b[49m";clear
}

display(){
    echo -e "\x1b[37m\x1b[40m"
    cat /record
    sleep 3
    echo -e "\x1b[30m\x1b[49m";clear
}

edit(){
    vi /record
}

hp(){
    echo -e "\x1b[36m\x1b[40m";clear
    PS1=''
    echo "this is a student's record manager program"
    sleep 3
    PS1='[\u@\h \W]\$'
    echo -e "\x1b[30m\x1b[49m";clear
}

tr(){
    if [ ! -e "/record" ];then
        echo "No record"
        exit 2
    fi
}

prompt=`echo -e "\033[40;32mPlease entry your choice [ 1 2 3 4 5 H Q]: \033[0m"`

while :
do
    clear
    show_menu
    read -p "${prompt}" choice
    case ${choice} in
    1)
        tr
        search
        ;;
    2)
        add
        ;;
    3)  
        tr
        delete
        ;;
    4)
        tr
        display
        ;;
    5)
        tr
        edit
        ;;
    H)
        hp
        ;;
    Q)
        echo "exit program"
        exit
        ;;
    *)
        echo "Please enter valid mode"
        sleep 3
        clear
    esac
done
