#!/bin/bash
#
# Lab 5
# Client-Server application
#
# Author: Cristian
# Date: 2013/10/29
# Var:  06
# Task: There're 2 app: client and server. Client send some data to server though pipe.
#       Server reads data, replace the penultimate letter in every world on capital one.
#
# == client ==
# just send some data through 'echo' to pipe file
#
# == Server ==
#

FIFO='/tmp/lab5_fifo'

if [[ -p $FIFO ]]; then
    rm -rf "$FIFO";
fi
mkfifo $FIFO

echo -e "echo, please, something into $FIFO"
echo -e "Listening for data from pipe ..."
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
