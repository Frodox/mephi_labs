#/bin/bash

# date: 18.10.2013
# task: input string. Convert all even chars(2nd, 4th, ...) to Upper one
# author: vika

echo "Введите строку"
read str
newstr=`echo $str | sed 's/^/\./g'`
echo "$newstr" | grep -q "\.[a-z][a-z]"
while [ "$?" -eq 0 ]
do
newstr=`echo $newstr | sed 's/\.\([a-z]\)\([a-z]\)/\1\2\./g'` 
newstr=`echo $newstr | sed 's/.\./\U&/g'`
echo "$newstr" | grep -q "\.[a-z][a-z]"
done
newstr=`echo $newstr | sed 's/\.//g'`
echo "Новая строка $newstr"
