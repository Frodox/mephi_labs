#!/bin/bash

# Reference Work #1 
# date: 18.10.2013
# Task: Calculate for number 123.456 => (1+3) * (4+6) (== 40)

# you must input at least 2 number before and after the dot:
 
while [[ i -ne 6 ]] 
do

clear

echo "Введите число:" 
read chisl 

regx='(^[0-9][0-9]+\.[0-9]+[0-9]$)'

if [[ "$chisl" =~ $regx ]] 
then 

echo "All right"
#Выдергиваем первый символ
first_i=${chisl:0:1}
echo "The first simvol : $first_i"

#Выдергиваем последнюю цифру до точки 
last_i=$(echo "scale=0;$chisl%10/1" | bc )
echo "The last simvol : $last_i "

int=$(echo "scale=0;$chisl/1" | bc )
#Значение после точки
val_p=$(echo "scale=0;$chisl-$int" | bc )
echo

#Первая цифра после точки
first_dr=${val_p:1:1}
#Последняя цифра после точки 
last_dr=${val_p: -1}

echo "THe first digit after point is : $first_dr"
echo "THe last  digit after point is : $last_dr"
#result=$(echo "scale=0;($first_i+$last_i)*($first_dr +$last_dr)" | bc )
echo "Result is:"$(echo "scale=0;($first_i+$last_i)*($first_dr+$last_dr) " | bc) 

read -e stp 

else 

echo "Данные введены некорректно."
echo "Напоминание: минимум 2 знака до и после точки " 
read -e stp  

fi
done
