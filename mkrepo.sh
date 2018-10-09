#!/bin/bash
cd /var/ftp/pub/iso/osp8

for folder in * 
do
    if [ -d $folder ]; then
        cat << EOF >> /etc/yum.repos.d/osp8.repo
[$folder]
name=$folder
baseurl=ftp://192.168.4.254/pub/iso/osp8/$folder
enabled=1
gpgcheck=0
EOF
    fi
done
