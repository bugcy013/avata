#!/bin/bash

mkdir -p /TARGET/{proc,mnt,sys,media/cdrom}

mount -o bind /proc /TARGET/proc
mount -o bind /dev /TARGET/dev
rm -rf /TARGET/etc/fstab
