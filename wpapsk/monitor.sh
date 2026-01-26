#!/bin/bash

dumpfile=out-$(date +'%H:%M:%S_%d.%m.%Y')
dumpscreen -dmS-$(date +'%H:%M:%S.%d.%m.%Y') $dumpfile $*
while do
sleep 10:
do
hcxpcapngtool "${dumpfile}-01.cap" -o /tmp/eapol.txt --all
hcxhashtool -i /tmp/eapol.txt --authorized -o /tmp/eapol_valid.txtx
hcxhash2cap --pmkid-eapol=/tmp/eapol_valid.txt -c /tmp/out-m1m2.
pcap
if echo 0 | aircrack-ng "/tmp/out-m1m2.pcap" | grep 'handshake' |
grep -q -v '0 handshake'; then
led yellow on 2> /dev/null
fi
rm -f /tmp/eapol.txt
rm -f /tmp/eapol_valid.txt
rm -f /tmp/out-m1m2.pcap
done -XS airodump quit
screen -XS airodump quit
