#!/bin/bash
# Auther: Mark Li
# Date:   2019-11-19
# Desc:   管理VNC服务

case $1 in
start)
    vncserver :1 -geometry 1380x1024 &> /dev/null
    run_port=`netstat -antpu | grep vnc | grep -v tcp6 | grep 59 | awk '{print $4}' | awk -F: '{print $2}'`
    echo "VNC Server Run on ${run_port}"
    ;;
status)
    netstat -antpu | grep vnc &> /dev/null
    if [ $? -eq 0 ];then
        run_port=`netstat -antpu | grep vnc | grep -v tcp6 | grep 59 | awk '{print $4}' | awk -F: '{print $2}'`
        echo "VNC Server is Running on ${run_port}"
    else
        echo "VNC Server is Not Running"
    fi
    ;;
stop)
    netstat -antpu | grep vnc &> /dev/null
    if [ $? -eq 0 ];then
        vncserver -kill :1 &> /dev/null
        echo "VNC Server Has Been Stopped"
    else
        echo "VNC Server is Not Running"
    fi
    ;;
*)
    echo "Usage: {start|stop|status}" >&2
esac
