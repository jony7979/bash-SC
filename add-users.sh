#! /bin/bash
#Рязанцев ЕА.
# создание пользователей с "/bin/false" из файла, который указанем как путь через переменную $1
# пример add-users.sh /home/jon/list-users.txt
PH=$(readlink -f $1) 
if [ "PH" != '' ]; then
for i in $(cat $PH)
do useradd -s /bin/false "$i"
done
else echo "Нет такого файла по пути $PH или значение переменной \$1 введены не верно"
fi
