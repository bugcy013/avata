#!/bin/bash

#gdm section
if [ -f /TARGET/etc/gdm/gdm.conf ]; then
#sed -i -e 's/AutomaticLogin/#AutomaticLogin/g' /TARGET/etc/gdm/gdm.conf
sed -i -e 's/true/false/g' /TARGET/etc/gdm/gdm.conf
fi
