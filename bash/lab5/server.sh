#!/bin/bash

# Lab 5
# Клиент-Серверное приложение
#
# == Server ==
#

FIFO='/tmp/lab5_fifo'

if [[ -p $FIFO ]]; then
    rm -rf "$FIFO";
fi
mkfifo $FIFO

echo -e "Listening for data from pipe:$FIFO ..."

while true; do

    if read line <$FIFO; then
            if [[ "$line" == 'quit' ]]; then
                break
            fi
            echo "pipe:> $line"
    fi
done

echo "Shutting server down..."
