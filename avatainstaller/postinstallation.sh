#!/bin/bash


# remove diverted update-initramfs as live-initramfs makes it a dummy file when booting the livecd
if [ -f /TARGET/usr/sbin/update-initramfs.debian ]; then
rm -f /TARGET/usr/sbin/update-initramfs
fi

# remove diverted update-notifier as it is disabled by live-config
if [ -f /TARGET/usr/lib/update-notifier/apt-check.debian ]; then
rm -f /TARGET/usr/lib/update-notifier/apt-check
fi

# remove diverted anacron as it is disabled by live-config
if [ -f /TARGET/usr/sbin/anacron.debian ]; then
rm -f /TARGET/usr/sbin/anacron
fi

# fix adept_notifier by copying the file we saved when remastersys first ran as live-initramfs removes it
if [ -f /TARGET/etc/remastersys/adept_notifier_auto.desktop ]; then
mv /TARGET/etc/remastersys/adept_notifier_auto.desktop /TARGET/usr/share/autostart/adept_notifier_auto.desktop
fi

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

#restore original inittab as live-initramfs changes it
cp /TARGET/usr/share/sysvinit/inittab /TARGET/etc/inittab


echo "$1" > /TARGET/etc/hostname
echo "127.0.0.1 localhost" > /TARGET/etc/hosts
echo "127.0.0.1 $1" >> /TARGET/etc/hosts
touch /TARGET/etc/resolv.conf

#gdm section
if [ -f /TARGET/etc/gdm/gdm.conf ]; then
#sed -i -e 's/AutomaticLogin/#AutomaticLogin/g' /TARGET/etc/gdm/gdm.conf
sed -i -e 's/true/false/g' /TARGET/etc/gdm/gdm.conf
fi

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


DEFAULTGROUPS="audio,cdrom,dialout,floppy,video,plugdev,netdev,powerdev"
. /etc/live/config.conf
cat > /TARGET/bin/tempinstallerscript <<FOO
#!/bin/bash

echo -e "$2\n$2\n" | passwd root
userdel -f -r avata
sed -i '/avata/d' /etc/sudoers
groupadd -g 1000 $3
useradd -u 1000 -g 1000 -c "$4" -G $DEFAULTGROUPS -s /bin/bash -m $3
sleep 120
echo -e "$5\n$5\n" | passwd $3
dpkg-divert --remove --rename --quiet /usr/lib/update-notifier/apt-check
dpkg-divert --remove --rename --quiet /usr/sbin/update-initramfs
dpkg-divert --remove --rename --quiet /usr/sbin/anacron
update-initramfs -t -c -k $(/bin/uname -r)
shadowconfig on
FOO

chmod 755 /TARGET/bin/tempinstallerscript
chroot /TARGET /bin/tempinstallerscript
rm /TARGET/bin/tempinstallerscript
rm -rf /TARGET/home/remastersys
rm -rf /TARGET/TARGET
rm -rf /TARGET/live
