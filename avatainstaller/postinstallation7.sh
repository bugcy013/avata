#!/bin/bash

#kde3 and kde4 section
if [ -f /TARGET/etc/default/kdm.d/live-autologin ]; then
rm -f /TARGET/etc/default/kdm.d/live-autologin
fi
if [ -f /TARGET/etc/kde3/kdm/kdmrc ]; then
sed -i -e 's/AutoLogin/#AutoLogin/g' /TARGET/etc/kde3/kdm/kdmrc
sed -i -e 's/AutoReLogin/#AutoReLogin/g' /TARGET/etc/kde3/kdm/kdmrc
fi
if [ -f /TARGET/etc/kde4/kdm/kdmrc ]; then
sed -i -e 's/AutoLogin/#AutoLogin/g' /TARGET/etc/kde4/kdm/kdmrc
sed -i -e 's/AutoReLogin/#AutoReLogin/g' /TARGET/etc/kde4/kdm/kdmrc
fi
