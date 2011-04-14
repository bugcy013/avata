#! /bin/bash

DEFAULTGROUPS="audio,cdrom,dialout,floppy,video,plugdev,netdev"
. /etc/live/config.conf
cat > /TARGET/bin/tempinstallerscript <<FOO
#!/bin/bash

echo "$1" > /TARGET/etc/hostname
echo "127.0.0.1 localhost" > /TARGET/etc/hosts
echo "127.0.0.1 $1" >> /TARGET/etc/hosts
touch /TARGET/etc/resolv.conf

useradd -c "$4" -G $DEFAULTGROUPS -s /bin/bash -m $3
sleep 50
echo "filecopyingggggggggggggggggggggggggg"
echo -e "$5\n$5\n" | passwd $3

echo -e "$2\n$2\n" | passwd root
userdel -f -r avata
sed -i '/avata/d' /etc/sudoers
dpkg-divert --remove --rename --quiet /usr/lib/update-notifier/apt-check
dpkg-divert --remove --rename --quiet /usr/sbin/update-initramfs
dpkg-divert --remove --rename --quiet /usr/sbin/anacron
update-initramfs -t -c -k $(/bin/uname -r)
shadowconfig on
FOO

sed -i 's/true/false/g' /TARGET/etc/gdm/gdm.conf
chmod 755 /TARGET/bin/tempinstallerscript
chroot /TARGET /bin/tempinstallerscript
rm /TARGET/bin/tempinstallerscript
rm -rf /TARGET/home/remastersys

rm -rf /TARGET/opt/avatainstaller

rm -rf /TARGET/usr/local/avatainstaller
