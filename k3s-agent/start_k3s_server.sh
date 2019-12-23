#!/bin/sh
while true; do
    k3s=`ps | grep k3s-server | grep -v grep | grep -v start`

    if [ ! "$k3s" ]; then
	./k3s-arm64 server --disable-agent --cluster-secret aibee2019 &
        sleep 10
    fi
    sleep 5
done

