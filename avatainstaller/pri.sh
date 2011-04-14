#!/bin/bash


if [ "`mount | grep $1`" ]; then
umount /dev/$1
fi
#mkswap /dev/$2
swapon /dev/$2
#mke2fs -j /dev/$1
mkdir -p /TARGET
mount /dev/$1 /TARGET -o rw
#tune2fs -c 0 -i 0 /dev/$1 
rm -rf /TARGET/lost+found

