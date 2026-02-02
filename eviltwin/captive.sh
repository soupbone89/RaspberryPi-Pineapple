#!/bin/bash

php -S 10.0.0.1:80 captive.php $* | while read line
do echo $line
    if echo "$line" | fgrep -q "password"; then
        led red on
    fi
done
