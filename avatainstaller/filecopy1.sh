#!/bin/bash

TARGETPARTUUID=`blkid /dev/$1 | awk '{print $2}' | awk -F '"' '{print $2}'`
TARGETSWAPUUID=`blkid /dev/$2 | awk '{print $2}' | awk -F '"' '{print $2}'`
TARGETCDROM=`cat /proc/mounts | grep "/live/image" | awk '{print $1}'
