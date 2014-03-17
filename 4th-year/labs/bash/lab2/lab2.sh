#!/bin/bash

# var:      6
# date:     08-oct-2013
# author:   Frodox
#
# Task: Разработать скрипт для ввода, редактирования, сортироки телефонного справочника
# вида: Фамилия И.О.
# Телефон: 8-916-ххх-хх-хх
# Предусмотреть проверку на дублирующие строки и корректность ввода.

### SETTINGS ###
ABOOK_FILE="Abook.txt"
TMPFILE=".Abook.txt.swp~"
###

. functions.sh

choise=0

# Main Menu
while [ $choise -ne 5 ]
do

clear
echo -e "Вас приветствует телефонный справочник v.0.1\n"

echo -e "1. Добавить абонента"
echo -e "2. Редактирование"
echo -e "3. Сортировка"
echo -e "4. А можно всех посмотреть?"
echo -e "5. Чао, Бомбино!"

echo
press_any_key_to_continue "Ваш выбор: " choise
echo -e ""
echo -e ""



case $choise in
    1)
        add_data
    ;;

    2)
        edit_data
    ;;

    3)
        sort_AB
    ;;

    4)
        echo "== $ABOOK_FILE =="
        if [ -f $ABOOK_FILE ]; then
            cat $ABOOK_FILE
        else
            echo -e "А база-то, пуста!"
        fi
    ;;

    5 | "q" )
        exit
    ;;

    *)
        echo "wtf, bro!"
        choise=0
    ;;
esac

# Stop screen, User read messages
press_any_key_to_continue "" key
if [[ $key == q ]]; then
    echo -e " \nBye Bye!"
    exit 0
fi
clear

done
