#!/bin/bash

# Frodox
# Lab 1
# date: 09.09.2013
# task: Cconversion of dollars into rubles at the set course to kopecks.
#       Producing a result in accordance with the rules of the Russian language.


###
### Trabslating settings ###
###
. gettext.sh
TEXTDOMAINDIR=.
TEXTDOMAIN=lab1
# delete this line, if want to test another added by yourself language
# in this case you should run it like: LANGUAGE=en_GB ./lab1.sh
LANGUAGE=ru_RU

export TEXTDOMAIN
export TEXTDOMAINDIR
export LANGUAGE
###


EX_RATE=31.9343   # $1 = EX_RATE rubles

# I'm lazy to translate this lines :D
echo -e "Вас приветствует конвертер долларов в рубли с точностью до копеек"
echo -e "по курсу Центра-Банка: \$1 = $EX_RATE руб."
echo -e "ver. 1.0\n"

# Input dollars count
echo -n "Введите кол-во долларов: $ "
read DOL_COUNT

# http://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
re='^[0-9]+([.][0-9]+)?$'
if ! [[ $DOL_COUNT =~ $re ]] ; then
   echo "error: Пожалуйста, введите корректное число долларов" >&2; exit 1
fi


RUB_tmp=$(echo "scale=2; $EX_RATE * $DOL_COUNT/1" | bc)
#echo -e "DBG: ${RUB_tmp} рублей"

RUBLS=$(echo "scale=0; $RUB_tmp / 1" | bc)
COP=$(echo "scale=0; 100 * ($RUB_tmp - $RUBLS)/1" | bc)

if [[ $RUBLS -ne 0 ]] ; then
    eval_ngettext "\$RUBLS ruble" "\$RUBLS rubles" $RUBLS; echo
fi

if [[ $COP -ne 0 ]] ; then
    eval_ngettext "\$COP cop" "\$COP cops" $COP; echo
fi
