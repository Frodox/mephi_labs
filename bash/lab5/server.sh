#!/bin/bash

# Lab 5
# Client-Server application
#
# == Server ==
#

FIFO='/tmp/lab5_fifo'

if [[ -p $FIFO ]]; then
    rm -rf "$FIFO";
fi
mkfifo $FIFO

echo -e "Listening for data from pipe:$FIFO ..."
echo

while true; do

    if read line <$FIFO; then
            if [[ "$line" == 'quit' ]]; then
                break
            fi

            for word in $line; do
                echo -n $word | sed ' s@\(.*\)\(.\)\(.\)@\1\u\2\3@';
                echo -n " ";
            done

            echo
            # echo -e "pipe:> $line"
    fi
done

echo "Shutting server down..."
