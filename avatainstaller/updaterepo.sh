#! /bin/bash

cat > /TARGET/bin/update-repo <<FOO
#!/bin/bash

apt-get update
FOO

chmod 755 /TARGET/bin/update-repo
chroot /TARGET /bin/update-repo
rm -f  /TARGET/bin/update-repo
