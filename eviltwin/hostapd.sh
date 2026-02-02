#!/bin/bash

essid="$1"
password="$2"

if [ -z "$password" ]; then
    config='hostapd-opn.conf'
else
    config='hostapd-wpa.conf'
fi

cp $config /tmp/$config
sed -i "s/__ESSID__/$essid/g" /tmp/$config
sed -i "s/__PASS__/$password/g" /tmp/$config

hostapd /tmp/$config | while read line
do
    if echo "$line" | fgrep -q 'AP-STA-CONNECTED'; then
        led green on 2> /dev/null
    elif echo "$line" | fgrep -q 'AP-STA-DISCONNECTED'; then
        led green off 2> /dev/null
    fi
done
