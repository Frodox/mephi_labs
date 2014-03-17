#!/bin/bash
# fantomouse | https://github.com/tolstovdmit (c)

rubley ()
{
  case "$1" in
	*[0,5-9]|*1[1-4]) res="$1 рублей";;
	*1) res="$1 рубль";;
	*[2-4]) res="$1 рубля";;
	*)res= "(none)" ;;
  esac

  echo -n $res
}

kopeek ()
{
  case "$1" in
	*[0,5-9]|*1[1-4]) res="$1 копеек";;
	*1) res="$1 копейка";;
	*[2-4]) res="$1 копейки";;
	*)res="(none)";;
  esac

  echo -n $res;
}

tovarov ()
{
  case " $1 " in
	*[0,2-9]|*11) res="$1 товаров" ;;
	*1) res= " $1 товара" ;;
	*) res= " (none) " ;;
  esac

  echo -n $res;
}

if [ $# -gt 3 -o $# -lt 2 ];
then
	echo "Не верное количество параметров" >&2;
	exit 1;
fi

#Проверяем на наличие входных переменных
if [ -z "$1" ];
then
	echo "Переменная количества (первая) пуста! >&2"
	exit 1
fi

if [ -z "$2" ];
then
	echo "Переменная цены (вторая) пуста! >&2"
	exit 1
fi


a="^-?[0-9]+$";
if ! [[ $1 =~ $a ]];
then
	echo "Первый аргумент $1 не число, лол?" >&2 ;
	exit 1;
fi

if ! [[ $2 =~ $a ]];
then
	echo "Второй аргумент $2 не число, лол?" >&2;
	exit 1;
fi


if ! [[ $3 =~ $a ]];
then
	echo "Третий аргумент $3 не число, лол?" >&2;
	exit 3;
fi

if [[ $3 -gt 99 ]];
then
	echo "Не бывает $3 копеек." >&2;
	exit 1;
fi

if [[ $1 -lt 0 ]];
then
	echo "Не может быть отрицательного количества." >&2;
	exit 1;
fi

if [[ $2 -lt 0 ]];
then
	echo "Не бывает отрицательных денег." >&2;
	exit 1;
fi

if [[ $3 -lt 0 ]];
then
	echo "Не бывает отрицательных денег." >&2;
	exit 1;
fi

#Если не вписаны копейки, то говорим, что их ноль
if [ -n "$3" ]; then
        inkop=$3;
else 
        inkop=0;
fi
discount=1;

#Заполняем оставшиеся переменные, чтобы в дальнейшем 
#Использовать их в выводе, ну и для удобства
inamount=$1;
inrub=$2;

#Определяем коэф. скидки
if [ $1 -gt 15 ];
then
	discount=0.85;

elif [ $1 -gt 10 ];
then
	discount=0.90;

elif [ $1 -gt 5 ];
then
	discount=0.95;
fi

#Делаем переменную с ценой, попутно складывая рубли и копейки в одно число
if [ -n "$inkop" ];
then
	cost=`echo "scale=2; $inrub+$inkop*0.01" | bc`;
else
	cost=$inrub;
fi

#Считаем стоимость с учетом скидки
cost=`echo "$cost*$inamount*$discount" | bc`;

#Разделяем рубли и копейки в две новые переменные
kop=`echo "$cost/1"     | bc`;
kop=`echo "$cost-$kop" | bc`;
kop=`echo "$kop*100"   | bc`;
kop=`echo "$kop/1"     | bc`;
rub=`echo "$cost/1"     | bc`;

echo -n "Стоимость "
tovarov $inamount
echo -n " по цене "
rubley $inrub
echo -n " "
kopeek $inkop
echo -n " = "
rubley $rub
echo -n " "
kopeek $kop
echo ".";
exit 0;
