#!/bin/bash

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
