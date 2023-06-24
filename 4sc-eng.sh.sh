#! /bin/bash
# ПОВТОРЕНИЕ АНГЛИЙСКИХ СЛОВ в РАНДОМНОМ порядке (желательно каждый день повторять)
# Файлы 4sc-eng.sh и eng-txt.txt должны лежать в одной папке и название файлов не переименовываем
# Для запуска, как вариант можно добавить путь, где будет лежать файл *.sh
# например: PATH=$PATH:/home/ИМЯ-ПОЛЬЗОВАТЕЛЯ  в .bashrc
# или /etc/bash.bashrc
# не забыть про chmod

clear

#query=sa
#set -e

while [ true ]
do
echo -e '\033[0m'"Для продолжения нажите Enter:"
read
ph=$(readlink -f $0)
ph2=$(echo $ph | sed 's/4sc-eng.sh/eng-txt.txt/')
#set -e
list=$(wc -l $ph2 | awk '{print $1}')
#r$(shuf -i 1-$list -n1)
#echo $r
r=$(($RANDOM % $list))
echo $r
if [ $r == 0 ]; then
r=$(($r + 1))
fi
echo -e "\t\t\t\t" '\033[0;32m'$(awk 'NR=='$r'' $ph2)

done

