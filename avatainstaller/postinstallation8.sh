#!/bin/bash

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
