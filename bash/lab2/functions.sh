# func for adress book lab

# Ask and Add data 
# to AdressBook 
add_data()
{
    fine_input=0
    # read input from user (in loop)
    echo -n "Введите данные в формате Фамилия И.О. +7-916-xxx-xx-xx: "
    read user
   

    regex="^[A-ZА-Я][a-zа-я]* [A-ZА-Я]\.[A-ZА-Я]\. \+7-916-[0-9]{3}-[0-9]{2}-[0-9]{2}$"

    # validate it 
    if [[ $user =~ $regex ]] ; then
        echo ""
    else
        echo "error: Не соответствует заданному формату" >&2;
        exit 1
    fi


    # check, if it already added into DB

    # add it
    echo "$user" >> $ABOOK_FILE
    echo "Success!"
    return 0
}



hello ()
{
    local mm="It's my Func!";
    echo "$mm"
    return 0
}


hello2 ()
{
    local __local=$1
    local mm='super puper texxxxt'
    eval $__local="'$mm'"

    return 0
}
