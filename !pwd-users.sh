#! /bin/bash
#Скрипт присваивает временные пароли указанным пользователям,
#а после входа просит создать пароль (под себя) пользователю
#Файл со временным Логином и Паролем находится по пути /root/pasusers.txt
#или переименовать на свой путь

>/root/pasusers.txt

#Синтексис pwd-users.sh [file-name]
#file-name - файл содердит массив users
# или нажать Enter, предложит указать отдельно логин поользователя

#cat /etc/bash.bashrc можно раскаментировать строки
#alias pw=pwd-users.sh  	- использовать pw команду
#или
#export PATH=$PATH:/root   	- для запуска файла pwd-users.sh (chmod o+x) проверить


fun1(){
pass=$(makepasswd)
echo "$i:$pass" | chpasswd;
chage -d 0 "$i"
echo -e "$(date +%d.%m.%y:%H.%M) $i \t\t$pass" >> /root/pasusers.txt
}

if [ -n "$1" ]; then
ph=$(readlink -f $1)
for i in $(cat $ph)
do
fun1
done
else
nuser=$(getent passwd {1000..1200} | cut -d ":" -f1)
echo -e "выберите пользователя из списка: \n$nuser \nУкажите пользователя:"
read
i=$(echo $REPLY)
fun1
fi


