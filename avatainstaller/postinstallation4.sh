#!/bin/bash

# copy trackerd stuff as live-initramfs disables it
if [ -f /TARGET/etc/remastersys/tracker-applet.desktop ]; then
mv /TARGET/etc/remastersys/tracker-applet.desktop /TARGET/etc/xdg/autostart/tracker-applet.desktop
fi
if [ -f /TARGET/etc/remastersys/trackerd.desktop.xdg ]; then
mv /TARGET/etc/remastersys/trackerd.desktop.xdg /TARGET/etc/xdg/autostart/trackerd.desktop
fi
if [ -f /TARGET/etc/remastersys/trackerd.desktop.share ]; then
mv /TARGET/etc/remastersys/trackerd.desktop.share /TARGET/usr/share/autostart/trackerd.desktop
fi
