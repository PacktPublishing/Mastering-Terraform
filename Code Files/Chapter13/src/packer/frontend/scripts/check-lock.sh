#!/bin/bash

echo "######### Checking apt lock"
echo "######### lslocks | grep '/var/lib/dpkg/lock-frontend'"
lslocks | grep '/var/lib/dpkg/lock-frontend'
while lslocks | grep '/var/lib/dpkg/lock-frontend'
do
    echo "######### File /var/lib/dpkg/lock-frontend already locked!"
    echo "######### lslocks"
    lslocks
    echo "######### sudo ps aux | grep -i apt"
    ps aux | grep -i apt
    echo "######### sudo lsof /var/lib/dpkg/lock-frontend"
    lsof /var/lib/dpkg/lock-frontend
    echo "######### Seeping a bit..."
    sleep 15
done
while lslocks | grep '/var/lib/apt/lists/lock'
do
    echo "######### File /var/lib/apt/lists/lock already locked!"
    echo "######### lslocks"
    lslocks
    echo "######### sudo ps aux | grep -i apt"
    ps aux | grep -i apt
    echo "######### sudo lsof /var/lib/apt/lists/lock"
    lsof /var/lib/apt/lists/lock
    echo "######### Seeping a bit..."
    sleep 15
done
echo "######### apt lock is not present, continuing..."