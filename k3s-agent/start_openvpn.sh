#!/bin/sh

#cd /dav/package/aibee_k3s
path=`pwd`

export PATH=$path/system/bin:$path/system/sbin:$PATH
export LD_LIBRARY_PATH=$path/system/lib:$LD_LIBRARY_PATH

while true; do
    vpn=`ps | grep openvpn | grep -v grep | grep -v start`
    if [ ! "$vpn" ]; then
	openvpn  --cd $path/system/etc/openvpn --config client.ovpn --log-append $path/system/etc/openvpn/openvpn.log
        sleep 10
    fi
    sleep 5
done




