#!/bin/sh

echo 'Getting RStop list ...'
sudo wget -q -nv 'https://raw.githubusercontent.com/BoboTiG/rstop-list/master/rstop.conf' -O /etc/dnsmasq.d/RStop.conf
sudo /usr/local/bin/gravity.sh

exit 0
