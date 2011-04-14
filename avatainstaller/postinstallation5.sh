#!/bin/bash

#restore original inittab as live-initramfs changes it
cp /TARGET/usr/share/sysvinit/inittab /TARGET/etc/inittab


echo "$1" > /TARGET/etc/hostname
echo "127.0.0.1 localhost" > /TARGET/etc/hosts
echo "127.0.0.1 $1" >> /TARGET/etc/hosts
touch /TARGET/etc/resolv.conf
