 #! /bin/bash
 
  if [ "$1" == "first" ]; then
 V1="second"
 elif [ "$1" == "second" ]; then
 V1="first"
 else echo "Нет такого файла по пути $(readlink -f script.sh)  или значение переменной \$1 введены не верно"
fi
 echo "$V1"

