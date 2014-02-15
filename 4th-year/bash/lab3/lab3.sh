#!/bin/bash

# var:      6
# date:     20-oct-2013
# author:   Frodox
#
# Task:  В текущем каталоге и всех подкаталогах переименовать файлы,
# начинающиеся на ‘a’, заменив первый символ на заглавный.


find . -type f | while read fpath; do

    new_path=$(echo "$fpath" |sed 's_^\(.*/\)\([aа]\)\(.*\)_\1\u\2\3_')

    if [[ $new_path != $fpath ]]; then
        # echo "Do mv to $new_path from $fpath"

        mv "$fpath" "$new_path"

        # mv -f "$fpath" "$(echo "$fpath" |sed 's_^\(.*/\)\([aа]\)\(.*\)_\1\u\2\3_')";
    fi

    done
