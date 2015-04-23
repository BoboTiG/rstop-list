#!/bin/sh

sudo wget -q -nv 'https://raw.githubusercontent.com/BoboTiG/rstop-list/master/rstop.conf' -O /etc/dnsmasq.d/RStop.conf
sudo wget -q -nv 'http://pgl.yoyo.org/as/serverlist.php?hostformat=dnsmasq&showintro=0&mimetype=plaintext' -O /etc/dnsmasq.d/pgl.yoyo.org.conf
sudo service dnsmasq restart

exit 0
