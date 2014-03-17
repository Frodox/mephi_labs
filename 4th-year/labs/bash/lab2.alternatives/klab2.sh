#!/bin/bash
REGNUM="^[0-9]{5}$"
REGWORD="^[A-Z][a-z]+$"
REGCHOICE_1="^[1-6]$"
REGCHOICE_2="^[1-4]$"
WORD="none"
#-----------------------------------------------------------------------------#
type_query () {
	echo -e "\033c"
	echo "-----------------------------------------"
	echo "Выберите действие:"
	echo "1) Вывести записи"
	echo "2) Добавить запись"
	echo "3) Редактировать запись"
	echo "4) Удалить запись"
	echo "5) Сортировать справочник"
	echo "6) Выйти"
	echo "-----------------------------------------"
	echo ""
	if [ "$1" = "" ] || ! [[ "$1" =~ $REGCHOICE_1 ]]
	then	
		echo "Ввод пустой или отсутствует в предложенном списке."
		echo ""
	fi
	echo -n "Сделай свой выбор: "
}
#-----------------------------------------------------------------------------#
sort_query () {
	echo -e "\033c"
	echo "--------------------------------"
	echo "Отсортировать книженцию по:"
	echo "1) Фамилии"
	echo "2) Имени"
	echo "3) Отчеству"
	echo "4) Телефону"
	echo "--------------------------------"
	echo ""
	echo -n "Сделай свой выбор: "
}
#-----------------------------------------------------------------------------#
show_all_records() {
	local C=`cat ABook | wc -l`
	C=`expr $C - 1`
	echo ""
	if [[ $C -le 0 ]]
	then
		echo "Нет записей или отсутствует файл с ними."
	else
		tail -$C ABook
	fi

}
#-----------------------------------------------------------------------------#
resort() {
	SORT_NUM=`head -1 ABook`
	
	sort -k$SORT_NUM ABook > tABook
	cat tABook > ABook
	rm tABook
}
#-----------------------------------------------------------------------------#
is_regexp_appropriate()
{
	if [[ "$WORD" =~ $1 ]]
	then
		return 0
	else
		return 1
	fi
}

is_five_phone()
{
	is_regexp_appropriate $REGNUM
}

is_word(){
	is_regexp_appropriate $REGWORD
}

#-----------------------------------------------------------------------------#
word_request(){

	echo -n "Введите $1: "
	
	while :
	do
		read WORD


		if [ "$WORD" = "q" ]
		then
			return
		elif ! [[ "$WORD" =~ $2 ]] 
		then
			echo ""
			echo "Не подходит по шаблону. (Имена с большой буквы на английском / Телефон 5 цифр) Попробуй еще раз."
			echo ""
			echo -n "Введите $1: "
		else
			break
		fi

	done
	
	echo $WORD
}
#-----------------------------------------------------------------------------#
sort_abook(){

	while : 
	do
		sort_query

		read SNS
		if [ "$SNS" = "" ] || ! [[ "$SNS" =~ $REGCHOICE_2 ]]
		then	
			echo ""
			echo "Ввод пустой или отсутствует в предложенном списке."
			echo ""
		else
			break
		fi
	done

	local C=`cat ABook | wc -l`
	C=`expr $C - 1`
	
	case "$SNS" in

		1) sort -k1 ABook | tail -$C  > tABook
		   echo "1" > ABook
		;;

		2) sort -k2 ABook | tail -$C  > tABook
       	   echo "2" > ABook
		;;

		3) sort -k3 ABook | tail -$C > tABook
		   echo "3" > ABook
		;;

		4) sort -k4 ABook | tail -$C > tABook
		   echo "4" > ABook
		;;

		5) return 
		;;

		*) echo "Ошибочка кая-то"
		   return
		;;
	esac

	cat tABook >> ABook
	rm tABook
}
#----------------------------------------------------------------------------#
#----------------------------------------------------------------------------#
add_record(){

	echo ""
	echo "Чтобы прервать операцию введите \"q\" "
	echo ""

	word_request "фамилию" $REGWORD
	if [ "$WORD" = "q" ] ; then	return ; fi
	
	local LASTNAME=$WORD 

	word_request "имя" $REGWORD
	if [ "$WORD" = "q" ] ; then	return ; fi
	
	local FIRSTNAME=$WORD	

	word_request "отчество" $REGWORD
	if [ "$WORD" = "q" ] ; then	return ; fi

	local THIRDNAME=$WORD	

	word_request "телефон" $REGNUM
	if [ "$WORD" = "q" ] ; then	return ; fi

	local PHONE=$WORD	

	local C=`cat ABook | wc -l`
	C=`expr $C - 1`
	LINE="$LASTNAME $FIRSTNAME $THIRDNAME $PHONE"
	local COUNT=`sort -k1 ABook | tail -$C | grep -c "$LINE"`

	echo ""
	if [[ $COUNT -eq 0 ]]
	then
		echo "$LASTNAME $FIRSTNAME $THIRDNAME $PHONE" >> ABook
		resort
		echo -n "Запись добавлена. Нажмите [Enter] для продолженния."
	else
		echo "Cудя по всему, такая запись уже есть. Придется всё заново вводить =("
	fi
	
	read
}
#-----------------------------------------------------------------------------#
edit_record(){

	show_all_records
	echo ""

	echo ""
	echo "Чтобы прервать операцию введите \"q\" "
	echo ""

	while :
	do
		echo -n "Фамилию и/или Имя и/или Отчество и/или телефон: "
		read LName FName TName TNumber

		if [[ "$LName" = "q" ]] ; then return ; fi

		LINE="$LName $FName $TName $TNumber"

		#"Эта строка магическим образом отрезает пробелы по краям строки"
		read -rd '' LINE <<< $LINE
		
		COUNT=`cat ABook | grep -ci "$LINE"`
		
		if [[ "$COUNT" -eq 0 ]]
		then
			echo ""
			echo "Нет записей соответствующих запросу."
			echo ""
		elif [[ "$COUNT" -gt 1 ]]
		then
			cat ABook | grep -i "$LINE"

			echo ""
			echo "Тут повторчики есть, введите поточнее."
			echo ""
		fi

		if [[ "$COUNT" -eq 1 ]]
		then 
			read LName FName TName TNumber <<< $(cat ABook | grep -i "$LINE")
			LINE="$LName $FName $TName $TNumber"
			break
		fi
	done

	echo ""
	echo "Чтобы оставить текущее оставьте поле неизмененным нажмите энтер"
	echo ""

	echo "Введите новое значение для фамилии."
	echo -n "Старое значение [$LName] :"

	while :
	do
		read newLName

		if [[ "$newLName" = "" ]] || [[ "$newLName" =~ $REGWORD ]] ; then break ; fi

		echo ""
		echo "Под формат не подошло. Попробуй еще."
		echo ""
		echo -n "Старое значение [$LName] :"
	done
	: ${newLName:=$LName}


	echo "Введите новое значение для имя."
	echo -n "Старое значение [$FName] :"
	
	while :
	do
		read newFName

		if [[ "$newFName" = "" ]] || [[ "$newFName" =~ $REGWORD ]] ; then break ; fi

		echo ""
		echo "Под формат не подошло. Попробуй еще."
		echo ""
		echo -n "Старое значение [$FName] :"
	done
	: ${newFName:=$FName}


	echo "Введите новое значение для отчество."
	echo -n "Старое значение [$TName] :"
	
	while :
	do
		read newTName

		if [[ "$newTName" = "" ]] || [[ "$newTName" =~ $REGWORD ]] ; then break ; fi

		echo ""
		echo "Под формат не подошло. Попробуй еще."
		echo ""
		echo -n "Старое значение [$FName] :"
	done
	: ${newTName:=$TName}


	echo "Введите новое значение для телефон."
	echo "Старое значение [$TNumber] :"

	while :
	do
		read newTNumber

		if [[ "$newTNumber" = "" ]] || [[ "$newTNumber" =~ $REGNUM ]] ; then break ; fi

		echo ""
		echo "Под формат не подошло. Попробуй еще."
		echo ""
		echo -n "Старое значение [$TNumber] :"
	done
	: ${newTNumber:=$TNumber}

	local C=`cat ABook | wc -l`
	C=`expr $C - 1`
	LINE="$newLName $newFName $newTName $newTNumber"
	local COUNT=`sort -k1 ABook | tail -$C | grep -c "$LINE"`

	if [[ $COUNT -eq 0 ]]
	then
		cat ABook | grep -iv "$LINE" > tABook
		echo "$newLName $newFName $newTName $newTNumber" >> tABook
		cat tABook > ABook
		rm tABook
		resort

		echo ""
		echo "Запись добавлена. Нажмите [Enter] для продолженния."
	else
		echo ""
		echo "Cудя по всему, такая запись уже есть. Придется всё заново вводить =("
	fi
	
	read
}
#-----------------------------------------------------------------------------#
delete_record(){

	show_all_records
	echo ""

	echo ""
	echo "Чтобы прервать операцию введите \"q\" "
	echo ""
		
	while :
	do
		echo -n "Фамилию и/или Имя и/или Отчество и/или телефон: "
		read LName FName TName TNumber

		if [[ "$LName" = "q" ]] ; then return ; fi

		LINE="$LName $FName $TName $TNumber"

		#"Эта строка магическим образом отрезает пробелы по краям строки"
		read -rd '' LINE <<< $LINE
		echo $LINE

		if [[ "$LINE" = "" ]]
		then
			echo "Запрос-то пустоват..."
			continue
		fi
		
		COUNT=`cat ABook | grep -ci "$LINE"`
		
		if [[ "$COUNT" -eq 0 ]]
		then
			echo ""
			echo "Нет записей соответствующих запросу."
			echo ""
		elif [[ "$COUNT" -gt 1 ]]
		then
			cat ABook | grep -i "$LINE"

			echo ""
			echo "Тут повторчики есть, введите поточнее"
			echo ""
		fi

		if [[ "$COUNT" -eq 1 ]]
		then

			echo "Вы действительно хотите удалить запись:"
			echo -n $(cat ABook | grep -i "$LINE")
			echo -n "[y/n]: "
			read D

			case "$D" in

				y|Y)
					cat ABook | grep -iv "$LINE" > tABook
					cat tABook > ABook
					rm tABook 

					echo ""
					echo "Запись удалена... Нажмите [Enter] для продолженния."
					echo ""
					break
				;;

				n|N) return ;;

				*) return ;;
			esac
		fi
	done

	read
}
#-----------------------------------------------------------------------------#
ANS=1
while :
do
	type_query $ANS

	read ANS

	case "$ANS" in
		1) show_all_records 
		echo ""
		echo -n "Нажмите энтер для продолженния..."
		read
		;;
		2) add_record
		;;
		3) edit_record
		;;
		4) delete_record
		;;
		5) sort_abook
		;;
		6) 
			echo -e "\033c"
			echo ""
			echo "ДО СКОРЫХ ВСТРЕЧ!"
			echo ""
			break 
		;;
		*) ;;
	esac

done

exit 0