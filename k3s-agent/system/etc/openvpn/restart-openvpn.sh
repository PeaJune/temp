#!/bin/sh
OID=`ps -ef | grep "/usr/sbin/openvpn --daemon" | grep -v grep | wc -l`
if [ ${OID} -eq 0 ]; then
/usr/sbin/openvpn --daemon --cd /etc/openvpn --config client.ovpn --log-append /etc/openvpn/openvpn.log
elif [ ${OID} -ne 1 ]; then
killall /usr/sbin/openvpn
/usr/sbin/openvpn --daemon --cd /etc/openvpn --config client.ovpn --log-append /etc/openvpn/openvpn.log
fi
