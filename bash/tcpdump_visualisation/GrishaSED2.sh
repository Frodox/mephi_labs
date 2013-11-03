#!/bin/bash

FILE=$1

cat $FILE | \
egrep "ARP|IP|IP6" | \
sed "s/, Request who-has//" | \
sed "s/, .*/ /" | \
cut -d' ' -f2,3,5 | 
awk '/ARP/ {print $2","$3} !/ARP/' | \
awk -F'[ .]' '/^IP\ / {print $2"."$3"."$4"."$5","$7"."$8"."$9"."$10} !/^IP\ /' | \
awk -F'[ .]' '/^IP6\ [0-9A-Fa-f:]*\./ {print $2","$4} !/^IP6\ [0-9A-Fa-f:]*\./' | \
awk '/IP6/ {print $2", " -> ", "$3} !/IP6/'  | \
uniq
