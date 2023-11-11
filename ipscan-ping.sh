#!/bin/bash
# Сканер сети по последнему актету.
# Нужно  задать сеть и диапазон хоста от и до
# Или указать при вызове скрипта # ./scanIP 192.168.0 1 20
# Предварительно не забыть про разрешение запуска chmod u+x scanIP.sh

if [ -z $1 ]; then
echo -e "Укажите три значания через пробел, \nне изменяемую часть сети, пиговать от и до 192.168.0 1 15 \:"
read ip3 ip1 ip2
else
ip3=$1 ; ip1=$2 ; ip2=$3
fi
        for ((i = $ip1 ; i <= $ip2 ; i++)); do
        lsip+=" $ip3.$i"
        done #for

echo $lsip | tr " " "\n" | xargs -I {} -P5 bash -c "ping -c3 {} &> /dev/null && echo {}:success || echo {}:fail"
