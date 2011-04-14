#!/bin/bash


# fix adept_notifier by copying the file we saved when remastersys first ran as live-initramfs removes it
if [ -f /TARGET/etc/remastersys/adept_notifier_auto.desktop ]; then
mv /TARGET/etc/remastersys/adept_notifier_auto.desktop /TARGET/usr/share/autostart/adept_notifier_auto.desktop
fi
