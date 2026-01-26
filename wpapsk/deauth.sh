#!/bin/bash

mdk4 mon0 d $* | while read line
do echo $line | echo $line
        led green on 2> /dev/null
        sleep '0.1'
        led green off 2> /dev/null
done
