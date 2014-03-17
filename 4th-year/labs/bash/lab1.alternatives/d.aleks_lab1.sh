#! /bin/bash

rate_is_euro_rate=0
rate_set=0
sum_set=0

args_count=${#@}

for ((arg_i = 1; arg_i <= args_count; ++arg_i)); do
	option=${!arg_i}

	case $option in
	"-?" | "-h" | "--help")
		echo "Лабораторная работа №1 студента группы К7-361 Алексеева Дмитрия"
		echo
		echo "Использование:"
		echo "lab1.sh [-e | --dollars_in_euro] [-r RATE | --rate RATE] [-s SUM | --sum SUM]"
		echo
		echo "-e, --dollars_in_euro    Трактовать курс как курс евро в долларах"
		echo "-r RATE, --rate RATE     Использовать курс RATE"
		echo "-s SUM, --sum SUM        Перевести SUM долларов в евро"
		exit
		;;
	"--version")
		echo "1.0"
		exit
		;;
	"-e" | "--dollars_in_euro")
		rate_is_euro_rate=1
		;;
	"-r" | "--rate")
		((++arg_i))
		if [[ $arg_i -gt $args_count ]]; then
			echo "Не задан аргумент для опции $option"
			exit 1
		fi
		rate=${!arg_i}
		rate_set=1
		;;
	"-s" | "--sum")
		((++arg_i))
		if [[ $arg_i -gt $args_count ]]; then
			echo "Не задан аргумент для опции $option"
			exit 1
		fi
		dollars_sum=${!arg_i}
		sum_set=1
		;;
	esac
done

if [[ $rate_set -eq 0 ]]; then
	if [[ $rate_is_euro_rate == 1 ]]; then
		echo -n "Введите курс евро в долларах: "
	else
		echo -n "Введите курс доллара в евро: "
	fi
	read rate
	rate_set=1
fi

if [[ $sum_set -eq 0 ]]; then
	echo -n "Введите сумму денег в долларах: "
	read dollars_sum
	sum_set=1
fi

if [[ $rate_is_euro_rate -eq 1 ]]; then
	euro_sum=`echo "scale=2; $dollars_sum/$rate" | bc`
else
	euro_sum=`echo "scale=2; $dollars_sum*$rate/1" | bc`
fi

euros=${euro_sum%.*}
cents=${euro_sum#*.}

((euros=euros))
((cents=cents))

cents_last=$(($cents%10))
cents_pre_last=$(($cents/10))

if [[ $cents_pre_last -eq 1 || $cents_last -eq 0 || $cents_last -ge 5 ]]; then
	cents_prompt="центов"
elif [[ $cents_last -eq 1 ]]; then
	cents_prompt="цент"
else
	cents_prompt="цента"
fi

echo -n "Сумма денег: "

if [[ $cents -eq 0 ]]; then
	echo "$euros евро"
elif [[ $euros -eq 0 ]]; then
	echo "$cents $cents_prompt"
else
	echo "$euros евро $cents $cents_prompt"
fi
