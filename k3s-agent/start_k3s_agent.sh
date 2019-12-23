#!/bin/sh

HOST_IP=$1
SERVER_IP=$2
PORT=$3

while true; do
    k3s=`ps | grep k3s-arm64 | grep -v grep | grep -v start`

    if [ ! "$k3s" ]; then
	./k3s-arm64 agent  --pause-image=advertise/pause:arm64 -s https://$SERVER_IP:$PORT \
				--node-name $HOST_IP  \
				--registry=http://$SERVER_IP:5000 \
				--cluster-secret aibee_edge_secret  \
				--registry-domain docker.io \
				--registry-user "" \
				--registry-pass "" \
				-v 2 \
				--kube-proxy-arg proxy-mode="ipvs" \
				--kube-proxy-arg ipvs-scheduler="wrr" \
				--resolv-conf /etc/resolv.conf \
				--log /var/log/k3s-agent.log \
				--kubelet-arg eviction-hard="imagefs.available<5%,memory.available<100Mi,nodefs.available<5%,nodefs.inodesFree<5%" \
				--kubelet-arg kube-reserved="cpu=100m,memory=100Mi,ephemeral-storage=100Mi" \
				--kubelet-arg system-reserved="cpu=400m,memory=100Mi,ephemeral-storage=100Mi" \
				--node-label "device=camera" \
				-d /mnt/nfs0/k3s 
        sleep 10
	rm -rf /mnt/nfs0/k3s/data
    fi
    sleep 5
done

