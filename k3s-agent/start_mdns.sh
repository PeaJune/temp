#!/bin/sh

#cd /dav/package/aibee_k3s
path=`pwd`

export PATH=$path/system/bin:$path/system/sbin:$PATH
export LD_LIBRARY_PATH=$path/system/lib:$LD_LIBRARY_PATH

while true; do
    mdns=`ps | grep mdnsd | grep -v grep | grep -v start`
    if [ ! "$mdns" ]; then
	mdnsd
        sleep 10
    fi
    sleep 10
done




