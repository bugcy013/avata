#!/bin/bash


# remove diverted update-initramfs as live-initramfs makes it a dummy file when booting the livecd
if [ -f /TARGET/usr/sbin/update-initramfs.debian ]; then
rm -f /TARGET/usr/sbin/update-initramfs
fi
