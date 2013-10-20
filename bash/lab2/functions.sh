# funcs for adress book lab


# realize PAUSE func in DOS.
# $1 promt
# $2 : pointer to pressed key value
press_any_key_to_continue()
{
    if [[ $# -ne 2 ]]; then
        echo -e "args: $# != 2 in func PAK2continue()";
        exit -1;
    fi

    read -rp $"$1" -n 1 key

    local  __resultvar=$2
    local  myresult=$key
    eval $__resultvar="'$myresult'"
}


# Ask and Add data to AdressBook
add_data()
{
    end_input=0

    while [ $end_input -ne 1 ]; do
        clear
        echo -n "Введите данные в формате [Фамилия И.О. +7-916-xxx-xx-xx]: "
        read user

        # check, if it 'q' and exit
        if [[ $user == q ]]; then
            echo -e " \n Input aborted...!";
            return;
        fi

        # regecp to validate data's format
        regex="^[A-ZА-Я][a-zа-я]* [A-ZА-Я]\.[A-ZА-Я]\. \+7-916-[0-9]{3}-[0-9]{2}-[0-9]{2}$"

        # validate it
        if [[ $user =~ $regex ]] ; then
            echo ""
            end_input=1;
        else
            echo -e "\nerror: Не соответствует заданному формату!"
            echo -e "Нажмите Any Key чтобы попробовать снова."
            press_any_key_to_continue "q : чтобы отменить ввод..." key

            if [[ $key == q ]]; then
                echo -e " \n Input aborted...!";
                return;
            fi
            # echo "error: Не соответствует заданному формату" >&2;

        fi
    done


    # If DB exists, check for duplicates
    if [ -f $ABOOK_FILE ]; then

        grep "$user" $ABOOK_FILE
        exit_code=$?

        if [[ $exit_code -eq 0 ]]; then
            echo -e "Хей, a такой товарищ-то, уже есть.\n"
            return;
        fi
    fi

    # add user
    echo "$user" >> $ABOOK_FILE
    echo -n "Success!"
}


# Sort Adress Book
# ask user for column to sort and do that
sort_AB()
{
    # if DB exist?
    if ! [[ -f $ABOOK_FILE ]]; then
        # mean file doesn't exist
            echo -en "Хей, а в базе то никого нима!"
            return;
    fi

    # ask, by witch column to sort
    echo
    press_any_key_to_continue "Сортировать по Фамилии[1], Инициалам[2], Телефону[3]: " key

    local sort_column=0;
    echo -ne "\nСортируем по "

    case $key in
    1)
        echo -e "Фамилии"
        sort_column=1
    ;;

    2)
        echo -e "Инициалам"
        sort_column=2
    ;;

    3)
        echo -e "Телефону"
        sort_column=3
    ;;

    *)
        echo -e ".. Ну ок, по Имени по умолчанию отсортирую :D"
        sort_column=1
    ;;
    esac
    echo

    # sorting
    echo "Sort column: $sort_column"

    # it will output also
    # good article about `sort`:
    # skorks.com/2010/05/sort-files-like-a-master-with-the-linux-sort-command-bash/
    cat $ABOOK_FILE | sort -k $sort_column | tee $TMPFILE

    # Write to DB
    mv $TMPFILE $ABOOK_FILE
}


# Ask user entry to edit,
# if such exists, ask for new one,
# and replace old line with new one
edit_data()
{
    # if DB exist?
    if ! [[ -f $ABOOK_FILE ]]; then
        # mean file doesn't exist
            echo -ne "\nНе обнаружена База Данныx. Сори ;)"
            return;
    fi




    end_input=0
    regex="^[A-ZА-Я][a-zа-я]* [A-ZА-Я]\.[A-ZА-Я]\. \+7-916-[0-9]{3}-[0-9]{2}-[0-9]{2}$"

    while [ $end_input -ne 1 ]; do
        clear
        echo -n "Введите данные для поиска и редактирования в формате [Фамилия И.О. +7-916-xxx-xx-xx]: "
        read user

        # check, if it 'q' and exit
        if [[ $user == q ]]; then
            echo -e " \n Editing aborted...!"; return;
        fi


        # validate input
        if [[ $user =~ $regex ]] ; then
            echo ""
        else
            echo -e "\nerror: Не соответствует заданному формату!"
            echo -e "Нажмите Any Key чтобы попробовать снова."
            press_any_key_to_continue "q : чтобы выйти..." key
            if [[ $key == q ]]; then
                echo -ne " \n Editing aborted...!"; return;
            fi

            echo
            continue
        fi

        grep "$user" $ABOOK_FILE
        exit_code=$?

        if [[ $exit_code -eq 0 ]]; then
            echo -e "Юзер детектед!\n"
            end_input=1;
            break
        else
            echo
            press_any_key_to_continue "Пользователь не найден! Попробуйте ещё разок :) " key
            continue
        fi
    done


    # ask for new user
    end_input=0
    while [ $end_input -ne 1 ]; do

        echo -n "Введите данные в формате [Фамилия И.О. +7-916-xxx-xx-xx]: "
        read new_user

        # check, if it 'q' and exit
        if [[ $new_user == q ]]; then
            echo -e " \n Input aborted...!";
            return;
        fi

        # regecp to validate data's format
        regex="^[A-ZА-Я][a-zа-я]* [A-ZА-Я]\.[A-ZА-Я]\. \+7-916-[0-9]{3}-[0-9]{2}-[0-9]{2}$"

        # validate it
        if [[ $new_user =~ $regex ]] ; then
            echo ""
            end_input=1;
        else
            echo -e "\nerror: Не соответствует заданному формату!"
            echo -e "Нажмите Any Key чтобы попробовать снова."
            press_any_key_to_continue "q : чтобы отменить ввод..." key

            if [[ $key == q ]]; then
                echo -e " \n Input aborted...!";
                return;
            fi
        fi
    done

    grep -v "$user" $ABOOK_FILE > $TMPFILE
    echo "$new_user" >> $TMPFILE
    mv $TMPFILE $ABOOK_FILE

    echo -n "Success!"
}

