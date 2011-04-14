#!/bin/bash


# remove diverted update-notifier as it is disabled by live-config
if [ -f /TARGET/usr/lib/update-notifier/apt-check.debian ]; then
rm -f /TARGET/usr/lib/update-notifier/apt-check
fi

# remove diverted anacron as it is disabled by live-config
if [ -f /TARGET/usr/sbin/anacron.debian ]; then
rm -f /TARGET/usr/sbin/anacron
fi
