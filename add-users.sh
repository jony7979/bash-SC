#! /bin/bash
PH=$(readlink -f $1)
if [ "PH" != '' ]; then
for i in $(cat $PH)
do useradd -s /bin/false "$i"
done
else echo "Нет такого файла по пути $PH или значение переменной \$1 введены не верно"
fi
