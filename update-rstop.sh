#!/bin/sh -eu

DEST="/etc/dnsmasq.d"

easylist() {
	echo -n 'Getting EasyList list ... '
	local out=$DEST/easylist.conf
	local tmp=$(mktemp)
	wget -q -nv https://easylist-downloads.adblockplus.org/easylist.txt -O $tmp
	egrep '^\|\|([a-Z\.]+)\^$' $tmp | cut -d '^' -f1 | sed 's#||#address=/# ; s#$#/127.0.0.1#' | sort | uniq >$tmp.$$
	[ $? -eq 0 ] && sudo mv -f $tmp.$$ $out && wc -l $out || echo -42
	rm $tmp
}

easylist_fr() {
	echo -n 'Getting EasyList FR list ... '
	local out=$DEST/easylist_fr.conf
	local tmp=$(mktemp)
	wget -q -nv https://easylist-downloads.adblockplus.org/liste_fr.txt -O $tmp
	egrep '^\|\|([a-Z\.]+)\^$' $tmp | cut -d '^' -f1 | sed 's#||#address=/# ; s#$#/127.0.0.1#' | sort | uniq >$tmp.$$
	[ $? -eq 0 ] && sudo mv -f $tmp.$$ $out && wc -l $out || echo -42
	rm $tmp
}

easyprivacy() {
	echo -n 'Getting EasyPrivacy list ... '
	local out=$DEST/easyprivacy.conf
	local tmp=$(mktemp)
	wget -q -nv https://easylist-downloads.adblockplus.org/easyprivacy.txt -O $tmp
	egrep '^\|\|([a-Z\.]+)[\^|\^\$third-party]$' $tmp | sed 's#||#address=/# ; s#\^.*#/127.0.0.1#' | sort | uniq >$tmp.$$
	[ $? -eq 0 ] && sudo mv -f $tmp.$$ $out && wc -l $out || echo -42
	rm $tmp
}

rstop() {
	echo -n 'Getting RStop list ... '
	local out=$DEST/rstop.conf
	local tmp=$(mktemp)
	wget -q -nv 'https://raw.githubusercontent.com/BoboTiG/rstop-list/master/rstop.conf' -O $tmp
	[ $? -eq 0 ] && sudo mv -f $tmp $out && wc -l $out || echo -42
}


rstop
easylist
easyprivacy
easylist_fr
sudo chmod 755 $DEST/*.conf

sudo /usr/local/bin/gravity.sh
