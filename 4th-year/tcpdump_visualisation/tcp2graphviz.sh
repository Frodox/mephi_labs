#!/bin/bash
#
# Date: 2016/12/10
# Author: Frodox, fantomouse
# License: GPL_v3
# Product: tcp2graphviz
# ------------------------------------------------------------------------
# See README.md for documentation
# ------------------------------------------------------------------------
#TODO:
# * need to add colors for graphviz
# * maybe some setting, like font and scale for graps
#-------------------------------------------------------------------------


if [[ $# -ne 2 ]]; then
    app_name=$(basename -- "$0")
    echo "usage: $app_name <INPUT TCPDUMP FILE> <OUTPUT GRAPHVIZ-FILE>"
    exit 1;
fi

FILE="$1"
RESULT_IP4="$2.ip4.dot"
RESULT_IP6="$2.ip6.dot"
TMP=$(mktemp)


echo "digraph tcpdump_graph_ip4 {" > "$RESULT_IP4"
echo "digraph tcpdump_graph_ip6 {" > "$RESULT_IP6"


# IPv4 --------------------------------------------------------------
echo -n "" > "$TMP"

grep -E -- "IP\ " "$FILE" | awk ' BEGIN { e="(([0-9]{1,3}.){3})([0-9]{1,3}).*" }
{
    printf "\"%s\" -> \"%s\";\n", gensub(e, "\\1\\3", "1", $3), gensub(e, "\\1\\3", "1", $5)
}' >> "$TMP"

sort -u "$TMP" >> "$RESULT_IP4"
echo "}" >> "$RESULT_IP4"



# IPv6 --------------------------------------------------------------
echo -n "" > "$TMP"

grep -E -- "IP6" "$FILE" | awk 'BEGIN { e="(([0-9a-fA-F:]{1,5}){1,5}):([0-9a-fA-F]{1,4}).*" }
{
    printf "\"%s\" -> \"%s\";\n", gensub(e, "\\1:\\3", "1", $3), gensub(e, "\\1:\\3", "1", $5)
}' >> "$TMP"

sort -u "$TMP" >> "$RESULT_IP6"
echo "}" >> "$RESULT_IP6"


rm -- "$TMP"




# for colors:
# $ echo "192.168.1.2" | awk '{ split ($1, a, "."); print a[1]  }'
# dot -Tsvg -o test-dot.svg test-dot.dot

# test regexp
# http://regex101.com

# correct ip6 regexp match. Works... but don't use this one! :D 
# http://snipplr.com/view/43003/
