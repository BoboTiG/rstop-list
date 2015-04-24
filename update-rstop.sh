#!/bin/sh

easylist() {
	echo -n 'Getting EasyList list ... '
	out=/etc/dnsmasq.d/easylist.conf
	tmp=$(mktemp)
	wget -q -nv https://easylist-downloads.adblockplus.org/easylist.txt -O $tmp
	egrep '^\|\|([a-Z\.]+)\^$' $tmp | cut -d '^' -f1 | sed 's#||#address=/# ; s#$#/127.0.0.1#' | sort | uniq >$tmp.$$
	[ $? -eq 0 ] && sudo mv -f $tmp.$$ $out && wc -l $out || echo -42
	rm $tmp
}

easylist_fr() {
	echo -n 'Getting EasyList FR list ... '
	out=/etc/dnsmasq.d/easylist_fr.conf
	tmp=$(mktemp)
	wget -q -nv https://easylist-downloads.adblockplus.org/liste_fr.txt -O $tmp
	egrep '^\|\|([a-Z\.]+)\^$' $tmp | cut -d '^' -f1 | sed 's#||#address=/# ; s#$#/127.0.0.1#' | sort | uniq >$tmp.$$
	[ $? -eq 0 ] && sudo mv -f $tmp.$$ $out && wc -l $out || echo -42
	rm $tmp
}

easyprivacy() {
	echo -n 'Getting EasyPrivacy list ... '
	out=/etc/dnsmasq.d/easyprivacy.conf
	tmp=$(mktemp)
	wget -q -nv https://easylist-downloads.adblockplus.org/easyprivacy.txt -O $tmp
	egrep '^\|\|([a-Z\.]+)[\^|\^\$third-party]$' $tmp | sed 's#||#address=/# ; s#\^.*#/127.0.0.1#' | sort | uniq >$tmp.$$
	[ $? -eq 0 ] && sudo mv -f $tmp.$$ $out && wc -l $out || echo -42
	rm $tmp
}

rstop() {
	echo -n 'Getting RStop list ... '
	out=/etc/dnsmasq.d/rstop.conf
	tmp=$(mktemp)
	wget -q -nv 'https://raw.githubusercontent.com/BoboTiG/rstop-list/master/rstop.conf' -O $tmp
	[ $? -eq 0 ] && sudo mv -f $tmp $out && wc -l $out || echo -42
}


rstop
easylist
easyprivacy
easylist_fr
sudo chmod 755 /etc/dnsmasq.d/*.conf

sudo /usr/local/bin/gravity.sh

exit 0
