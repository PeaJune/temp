#!/bin/bash

export LD_LIBRARY_PATH=./:LD_LIBRARY_PATH


sudo ./mdnsd
sleep 1
./dns-sd -R "k3s_server" _http._tcp . 6443 path=/ &



