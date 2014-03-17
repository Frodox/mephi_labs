#!/bin/bash

. functions.sh

echo -e "Print args"

echo -e $@
echo -e $#

press_any_key_to_continue "Ваш выбор: " key

echo
echo -e "Returned value: $key"
