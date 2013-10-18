#!/bin/bash

# Frodox
# Kr1
# date: 18.19.2013
# task: Input number. Ceil it to 2 nums in float pathe.



echo -e "Контрольная рабоат №1"
echo -e "Автор: Рыбников Виталий."
echo -e "\n"

echo -n "Введите число: "
read NUM

re='^[-]*[0-9]+([.][0-9]+)?$'
if ! [[ $NUM =~ $re ]] ; then
   echo "error: Пожалуйста, введите корректное число" >&2; exit 1
fi



printf "Округляем...\n"
sleep 0.5
printf "Результат: %.2f \n" ${NUM}


