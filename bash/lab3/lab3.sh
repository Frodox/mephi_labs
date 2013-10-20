#!/bin/bash

# var:      6
# date:     20-oct-2013
# author:   Frodox
#
# Task:  В текущем каталоге и всех подкаталогах переименовать файлы,
# начинающиеся на ‘a’, заменив первый символ на заглавный.


#!bin/bash
rename_a_files()
{
    dir=$1    # dir - is folder
    cd $dir

    ls -A | while read item; do

            if [[ -d $item ]] ; then
                (rename_a_files $item)
            else
                echo "File: $item"
                echo $f | grep '^a'
                if [[ $? == 0 ]]; then
                    newf=`echo $f | sed 's/^a/b'`
                    mv $f $newf
                fi
            fi
        done
}

#rename_a_files .

find . -type f | while read fpath; do

    new_path=$(echo "$fpath" |sed 's_^\(.*/\)\([aа]\)\(.*\)_\1\u\2\3_')

    if [[ $new_path != $fpath ]]; then
        echo "Do mv for $new_path"

        # mv -f "$fpath" "$(echo "$fpath" |sed 's_^\(.*/\)\([aа]\)\(.*\)_\1\u\2\3_')";
    fi

    # echo -e "File: $fpath"
    # echo -e "New path: $new_path"
    # echo
    
    done
