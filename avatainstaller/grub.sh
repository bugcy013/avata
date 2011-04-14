#!/bin/bash
#script based on remastersys by Tony "Fragadelic" Brijeski


ROOTMOUNT="$1"
if [ "$ROOTMOUNT" = "" ]; then
ROOTMOUNT="/"
fi

ROOTPART=`mount | grep " $ROOTMOUNT " | awk '{print $1}'`
GRUBLOCTEST="$2"
if [ "$GRUBLOCTEST" = "root" ]; then
GRUBLOC="$ROOTPART"
else
GRUBLOC="/dev/sda"
fi



if [ "$ROOTMOUNT" != "/" ]; then
chroot $ROOTMOUNT grub-install --no-floppy $GRUBLOC
chroot $ROOTMOUNT update-grub
else
grub-install --no-floppy $GRUBLOC
update-grub
fi



