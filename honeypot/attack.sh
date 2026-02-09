#!/bin/bash

HOME='/home/pi'

screen -dmS Xorg xinit -- /usr/bin/X :0 -br # optional for GUI
attacking script
rm /tmp/honeypot_attacks.txt 2> /dev/null

for script in $(find on_network/ -type f -perm -u+x)
do
    exec sudo $script wlan0 "" &
done

while sleep 1
do
    arp -an | sed -n 's/\? \(([^\)]+)\) .*\[ether\] on wlan0/\1/p' |
while read ip
  do
    egrep -q "^$ip$" /tmp/honeypot_attacks.txt 2> /dev/null &&
    continue || echo "$ip" >> /tmp/honeypot_attacks.txt
    for script in $(find on_client/ -type f -perm -u+x)
    do
      exec $script $ip "" 10.0.0.1 &
    done
  done
done
