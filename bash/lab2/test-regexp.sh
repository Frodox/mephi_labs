#!/bin/bash

regex="^[A-ZА-Я][a-zа-я]* [A-ZА-Я]\.[A-ZА-Я]\. \+7-916-[0-9]{3}-[0-9]{2}-[0-9]{2}$"

test () {

i="$1"

if [[ $i =~ $regex ]] ; then
        echo -e "$i \t: OK"
    else
        echo -e "$i \t: not OK"
    fi
}

echo "$regex"

# test "Леонид М.А."
# test "Leonid M.A."
test "$1"

