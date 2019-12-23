#!/bin/bash

export LD_LIBRARY_PATH=./:$LD_LIBRARY_PATH
sudo ./mdnsd
result=$(./getserviceip k3s_server _http._tcp. local | awk -F ":" '{print $2}')

echo $result
#echo $(echo $result | awk -F " " '{print $1}')

#for x in $result; do
#	echo $x
#done
