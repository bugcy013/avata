#!/bin/bash


TARGETPARTUUID=`blkid /dev/$1 | awk '{print $2}' | awk -F '"' '{print $2}'`
TARGETSWAPUUID=`blkid /dev/$2 | awk '{print $2}' | awk -F '"' '{print $2}'`
TARGETCDROM=`cat /proc/mounts | grep "/live/image" | awk '{print $1}'`


rsync -a / /TARGET --exclude=/{TARGET,live,cdrom,mnt,proc,sys,media}
mkdir -p /TARGET/{proc,mnt,sys,media/cdrom}

mount -o bind /proc /TARGET/proc
mount -o bind /dev /TARGET/dev
rm -rf /TARGET/etc/fstab
cat > /TARGET/etc/fstab <<FOO
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>

proc /proc proc defaults 0 0
# /dev/$1
UUID=$TARGETPARTUUID / ext3 relatime,errors=remount-ro 0 1
# /dev/$2
UUID=$TARGETSWAPUUID none swap sw 0 0
# cdrom
$TARGETCDROM /media/cdrom udf,iso9660 user,noauto,exec,utf8 0 0

FOO

