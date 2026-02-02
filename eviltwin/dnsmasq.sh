#!/bin/bash

dnsmasq --conf-file=dnsmasq.conf -d | while read line
do
    if echo "$line" | fgrep -q 'DHCPACK'; then
        led yellow on 2> /dev/null
    fi
done
