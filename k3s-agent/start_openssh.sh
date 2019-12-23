#!/bin/sh

#cd /dav/package/aibee_k3s
path=`pwd`

export PATH=$path/system/bin:$path/system/sbin:$PATH
export LD_LIBRARY_PATH=$path/system/lib:$LD_LIBRARY_PATH

mkdir -p /etc/ssh/
mkdir -p /home/gjhou/openssh/openssh-8.0p1/__install/

cp $path/system/etc/ssh/* /etc/ssh/ -rf
chmod 600 /etc/ssh/*

#added sshd group
cat /etc/group | grep sshd >> /dev/null
if [ $? = 1 ]; then
        echo "sshd:x:0:" >> /etc/group
fi

#added sshd user
cat /etc/passwd | grep sshd  >> /dev/null
if [ $? = 1 ]; then
	cat /etc/passwd | grep admin | sed 's/admin/sshd/' >> /etc/passwd
fi


while true; do
    sd=`ps | grep sshd | grep -v grep | grep -v start`
    if [ ! "$sd" ]; then
	$path/system/sbin/sshd -f /etc/ssh/sshd_config
        sleep 10
    fi
    sleep 30
done




