#!/bin/bash

chmod 755 /TARGET/bin/tempinstallerscript
chroot /TARGET /bin/tempinstallerscript
rm /TARGET/bin/tempinstallerscript
rm -rf /TARGET/home/remastersys
rm -rf /TARGET/TARGET
rm -rf /TARGET/live
