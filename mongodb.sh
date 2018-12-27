#!/bin/bash
proc="/usr/local/mongodb/bin/mongod"
conf="/usr/local/mongodb/etc/mongodb.conf"

case $1 in
start)
    ${proc} -f ${conf} &> /dev/null
    [ $? -eq 0 ] && echo "Starting.." || echo "Starting Failed.."
    ;;
stop)
    ${proc} --shutdown -f ${conf} &> /dev/null
    [ $? -eq 0 ] && echo "Stopping.." || echo "Stopping Failed.."
    ;;
status)
    netstat -antpu | grep mongod &> /dev/null
    if [ $? -eq 0 ];then
        hp=`netstat -antpu | grep mongod | awk '{print $4}'`
        echo "MongoDB is running on ${hp}"
    else
        echo "MongoDB is not running.."
    fi
    ;;
*)
    echo "Usage {start|stop|status}"
    ;;
esac

