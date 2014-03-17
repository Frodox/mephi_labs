#!/bin/bash

if [[ 0 == $# ]]; then
        echo "Nee path/to/file!"
        exit -1;
fi

if [[ ! -f $1 ]]; then
    echo "Bad filename!";
    exit -1;
fi

FILE=$1
sort $FILE | awk -F"[ -]" '{

if( ( int(x[$1])-$7)!=1 && ( $7-int(x[$1]) )!=1 ) 
{
    print $0;
    x[$1]=$7
}
}'


 # awk -F"[ -]" '{ print $1, $7; if ( 1!=(int(x[$1] - $7)) { print "Not ", $7+1, "Save it!"; x[$1]=$7; } else { print "not this one"; } }'
