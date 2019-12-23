#!/bin/sh

#cd /dav/package/aibee_k3s
#path=`pwd`
sleep 30
cur=`dirname $0`
cd $cur
path=`pwd`

export PATH=$path:$PATH

umount /sys/fs/cgroup
./cgroupfs-mount
mount --make-shared /

#copy root certs to /etc/ssl/certs
mkdir -p /etc/ssl/certs
cp $path/system/etc/ssl/certs/* /etc/ssl/certs -rf

export PATH=$path/system/bin:$path/system/sbin:$PATH
export LD_LIBRARY_PATH=$path/system/lib:$LD_LIBRARY_PATH

#SERVER_IP=192.168.80.13
SERVER=aibee_edge_server

#added nameserver 114.114.114.114
cat /etc/resolv.conf | grep 114.114.114.114
if [ $? = 1 ]; then
	echo "nameserver 114.114.114.114" >> /etc/resolv.conf
fi

while true;
do
	HOST_IP=`ifconfig eth0 | grep "inet addr:" | awk '{print $2}' | awk -F':' '{print $2}'`
	if [ ! "$HOST_IP" ]; then
		echo "wait network get ip address."
		sleep 5
		continue
	fi
	#echo "break..."
	break
done

echo $HOST_IP
#start openvpn
#./start_openvpn.sh &
#sleep 5


#start openssh
./start_openssh.sh &
sleep 5
#start mdns
./start_mdns.sh &
sleep 5
while true;
do
	getserviceip $SERVER _http._tcp local > ip_list
	if [ $? != 0 ];then
		continue
	fi

	line=`cat ip_list | wc -l`

	if [ $line -eq "2" ]; then
		echo "ip conflict..."
		echo "ip conflict..."
		echo "ip conflict..."
		continue
	fi

	str=`sed 's/\r//' ip_list`
	ip=`echo $str | awk -F':' '{print $2}' | xargs`
	port=`echo $str | awk -F':' '{print $3}' | xargs`

	break
done
SERVER_IP=$ip
PORT=$port

#start k3s server
#./start_k3s_server.sh &
#sleep 30

./start_k3s_agent.sh $HOST_IP $SERVER_IP $PORT &
