#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "usage: $0 <INPUT DUMP FILE> <OUTPUT GRAPHVIZ-FILE>"
    exit 1;
fi

FILE=$1
RESULT=$2
TMP=$(mktemp)

# Clear file, if exists
echo "digraph tcpdump {" > $RESULT

cat $FILE | \
egrep "ARP|IP|IP6" | \
sed "s/, Request who-has//" | \
sed "s/, .*/ /" | \
cut -d' ' -f2,3,5 | 
awk '/ARP/ {printf "\"%s\" -> \"%s\";\n", $2,$3; } !/ARP/' | \
\
awk -F'[ .:]' '/^IP\ / {printf "\"%d.%d.%d.%d\" -> \"",$2,$3,$4,$5; if (($6+0)==$6 && $6<255){ printf "%d.",$6; } printf "%d.%d.%d",$7,$8,$9; if(($10+0)==$10) { printf ".%d",$10;} printf "\";\n"; } !/^IP\ /' | \
\
awk -F'[ .]' '/^IP6\ [0-9A-Fa-f:]*\./ {printf "\"%s\" -> \"%s\";\n", $2,$4; } !/^IP6\ [0-9A-Fa-f:]*\./' | \
# awk '/IP6/ {printf "\"%s\" -> \"%s\";\n", $2,$3; } !/IP6/'
awk '/IP6/ {printf "\"%s\" -> \"%s\";\n", $2,$3; } !/IP6/' >> $TMP


sort -u $TMP >> $RESULT
echo "}" >> $RESULT
