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
###

. functions.sh 

choise=0

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
read -r -n 1 -p "Ваш выбор: " choise
echo
echo

#echo "DBG: Inputted: " $choise

case $choise in
    1)
    add_data
    echo    
    ;;
    
    2)
    echo "Editing..."
    ;;
    
    3)
    echo "Sorting..."
    ;;

    4)
    echo "Show..."
    ;;
    
    5 | "q" )
    exit
    ;;

    *)
    echo "wtf, bro!"
    choise=0
    ;;
esac

# pause
read -rsp $'' -n 1  key
if [[ $key == q ]]; then
    echo "Bye Bye!"
    exit 0
fi
clear

done

