#!/bin/bash
#Рязанцев. Версия ...
#Скрипт создает виртуальную машину в интрактивном режиме.
#
# Вывести информацию о предустановленных вирт. машинах и их количестве.
#alias vm='bash vm.sh'

#===================================
#Функция2

#=====================================

#Функция1
# $1-команда  
fun1()
{
#	if [[ "$1" != [xX] ]] ; then
namelistVM=""
read -p "Укажи № номера ВМ или [eXit]:" listnameVM
	
[[ $listnameVM =~ [Xx] ]] && continue
	for numVB in $listnameVM # Номер в имя машины
        do 
	if [[ $numVB =~ ^[0-9]+$ ]] ; then
namelistVM+=" $(prlctl list -a | awk 'NR>1 {print S1="VM:\t\t"$5,$3="\t",$2}'| grep -n VM: | grep -w ^$numVB | awk '{print $2}')"

	else
echo "Некорректный указан аргумент ВМ: $numVB"
        fi	
	done #Номер в имя машины

	#Действие со списком ВМ
nameVM=""
	for nameVM in $namelistVM
        do
#echo $numVB
#echo $nameVM
#echo "$1"
echo "$nameVM####################$nameVM#######################$nameVM"
request=""
read -p "Будет $1 ВМ: $nameVM [Y/n]" request && ( [[ $request =~ [Yy] ]] && prlctl $1 $nameVM ) || continue 	
        	
	done #Действие со списком ВМ
#	else
#echo " "
#fi
}

#===========================================================================================
#===========================================================================================
X=0
	until [[ $X == [Xx] ]]
	do

echo "........................................................................."
echo "$(prlctl list -a | awk 'NR>1 {print S1="VM:\t\t"$5,$3="\t",$2}'| grep -n VM: | column -t | pr -t -2 )"
echo "........................................................................."
echo "Создать(c) Настройки>>(e) Запустить(r) \
Запуст.ВСЕ(R) Рестарт(Z) Остановить(s) Останов.ВСЕ(S) \
Удалить(d) Информация(i) Список(L) Клон.(k) Выход(x)" | tr -s " " "\n" | pr -t -4
 
echo "........................................................................."
read -p "  Укажите действие или [eXit]:" actionVM

#ccccccccccccccccccccccccccccccccc======================================================================
# 1. Присваиваем имя виртальной машине.
	if [[ $actionVM == [Cc] ]] ; then
echo -n "Введите имя новой ВМ,(eXit):"
read VRcreate

#11111111111111111111111
	if [[ $(prlctl list -a | awk 'NR>1 {print $5}' | grep -q $VRcreate) ]] ; then
echo "ВНИМАНИЕ!!!!!!!!!! Совпадение имени ВМ, будет перезалита или нажмите прервать"
#break
#exit
	fi
#1111111111111111111111

#until [[ $VRcreate == [Xx] ]]
#	do
# 1. Укажите количество соккетов
# read -e -p "Укажите количество соккетов <default>: " -i "1" VRsockte
# 2. Укажите количичества ядер, по умолчанию 4 ядра
read -e -p "Укажите количичества ядер <default>: " -i "4" VRcpus
# 3. Размер hdd под виртуальную машину
read -e -p "Размер диска, в Gb, <default>: " -i "50" VRsize
VRsize="${VRsize}G"
# 4. Размер перативной памяти
read -e -p "Размер ОЗУ, в Gb, <default>: " -i "4" VRmemsize
VRmemsize="${VRmemsize}G"
# 5. Размер видео памяти
read -e -p "Размер видео памяти, в Mb <default>: " -i "32" VRvideosize
VRvideosize="${VRvideosize}M"
echo -e " \n"
echo -e "1. create a directory -> /vz/vmprivate \n2. copy in -> /vz/vmprivate the "system_image.iso" for the created VM:" 
read -p "Is this ok? - Continue [Enter]?"
echo " "
ls -1 /vz/vmprivate
echo " "
echo -n "Укажите образ iso:" 
read VRnameiso
VRname="/vz/vmprivate/${VRnameiso}"
echo $VRname
echo -e " \nChecking: \n"
echo -e "NAME VM:\t$VRcreate \nCORES:\t\t$VRcpus \nDISK_SIZE:\t$VRsize \
\nMEMORY_SIZE:\t$VRmemsize \nVIDEO_SIZE:\t$VRvideosize\n "

read -p "Create a virtual machine with parameters [Enter/n]?"
	if ! [[ $REPLY == [Nn] ]] ; then
prlctl create $VRcreate --distribution linux >/dev/null
prlctl set $VRcreate --cpus $VRcpus --size $VRsize --memsize $VRmemsize --videosize $VRvideosize --autostart auto --tools-autoupdate off 
#>/dev/null
prlctl set $VRcreate --device-set cdrom0 --image $VRname --connect --enable 
#>/dev/null
prlctl set $VRcreate --vnc-mode auto --vnc-nopasswd 
#>/dev/null
prlctl start $VRcreate
sleep 3
echo -e "Port: \t$(prlctl list -i $VRcreate | grep -o 'port=[^ ,]\+' | sed 's/port=//')"
VRcreate=X
	else
echo "Exit"
	fi
#	done

#НАСТРОЙКИeeeeeeeeeeeeeeeeeeeee======================================================================

	elif [[ $actionVM == [Ee] ]] ; then
XXX=0
	until [[ $XXX == [Xx] ]]
        do
echo "\nИЗМЕНЕНИЕ ВМ:"
echo "Переимен._ВМ_(n) Миграция_(m) Процессор_(u) \
Снапшет_(s) Вирт.память_(q) Выход_(x)" | tr -s " " "\n" | pr -t -3


read -p "Укажите значение:" editVM

        if [[ $editVM == [n] ]] ; then
echo "Команда находится в разработке."
        elif [[ $editVM == [m] ]] ; then
echo "Команда находится в разработке."
        elif [[ $editVM == [u] ]] ; then
echo "Команда находится в разработке."
        elif [[ $editVM == [q] ]] ; then
echo "Команда находится в разработке."
        elif [[ $editVM == [xX] ]] ; then
XXX=X
        else
echo "Значение не бырано"

        fi
        done
#done

#rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr===================================================
	elif [[ $actionVM == [r] ]] ; then
echo "Старт ВМ"
fun1 "start"

#RRRRRRRRRRRRRRRR========================================================================

	elif [[ $actionVM == [R] ]] ; then
echo -n "Запустить ВСЁ ВМ?, < enter name [Y/n] >"
read runallVM
	if [[ $runallVM == [Yy] ]] ; then
for vm in $(prlctl list -i | grep Name: | sed 's\Name: \\g' | tr "\n" " ") ; do prlctl start $vm ; done
	else
exit
	fi

#sssssssssssssss==========================================================================

	elif [[ $actionVM == [s] ]] ; then
echo "СТОП ВМ"
fun1 "stop"

#SSSSSSSSSSSSSSSSSSSS====================================================================

	elif [[ $actionVM == [S] ]] ; then
echo -n "Остановить ВСЁ ВМ ? < enter name [Y/n] >"
read stopallVM
	if [[ $stopallVM == [Yy] ]] ; then
for vm in $(prlctl list -o name) ; do prlctl stop $vm ; done
# Можно добавить -k  для быстрого выключения : do prlctl stop $vm -k
	else
exit
	fi

#ZZZZZZZZZZZZZZZZZZZZZZ====================================================================

	elif [[ $actionVM == [zZ] ]] ; then
echo "Перезагрузка ВМ:"
fun1 "restart"

#ddddddddddddddddddd========================================================================

	elif [[ $actionVM == [Dd] ]] ; then
echo "Удаление ВМ:"
fun1 "delete"

#echo -n "Select VM for delete, enter name:"
#read deleteVM
#echo "Delete VM?, < enter name [Y/n] >"
#read yndelVM
#	if [[ $yndelVM == [Yy] ]] ; then
#prlctl delete $deleteVM
#echo "VM $deleteVM deleted "
#	else
#echo "VM $deleteVM NO delete"
#	fi

#iiiiiiiiiiiiiiiii==========================================================================

	elif [[ $actionVM == [Ii] ]] ; then
echo "Информация ВМ:"

#echo -n "Information VM, enter name:"
#read infoVM
fun1 "list -i" 
#echo -e "Name: \t\t$(prlctl list -i $infoVM | grep -o 'Name: [^ ,]\+' | sed 's/Name: //')"
#echo -e "Uptime: \t$(prlctl list -i $infoVM | grep -o '(since [^ ,]\+ [^ ,]\+' | sed 's/since //')"
#echo -e "State: \t\t$(prlctl list -i $infoVM | grep -o 'State: [^ ,]\+' | sed 's/State: //')"
##echo -e "Sockets: \t$(prlctl list -i $infoVM | grep -o 'sockets=[^ ,]\+' | sed 's/sockets=//')"
#echo -e "CPU: \t\t$(prlctl list -i $infoVM | grep -o 'cpus=[^ ,]\+' | sed 's/cpus=//')"
#echo -e "Memory: \t$(prlctl list -i $infoVM | grep -o 'memory [^ ,]\+'| sed 's/memory //')"
#echo -e "Video: \t\t$(prlctl list -i $infoVM | grep -o 'video [^ ,]\+' | sed 's/video //')"
#echo -e "HDD: \t\t$(prlctl list -i $infoVM | grep hdd | grep -o '[^ ,]\+Mb' | sed 's/ //')"
#echo -e "Name_hdd: \t$(prlctl list -i $infoVM | grep hdd | grep -o 'image=[^ ,]\+' | sed 's/image=//')"
#echo -e "Cdrom: \t$(prlctl list -i $infoVM | grep cdrom | grep -o 'image=[^ ,]\+' | sed 's/image=//')"
#echo -e "Port: \t\t$(prlctl list -i $infoVM | grep -o 'port=[^ ,]\+' | sed 's/port=//')"
#echo -e "IP: \t\t$(prlctl list -i $infoVM | grep -o 'address=[^ ,]\+' | sed 's/address=//')"

#LLLLLLLLLLLLLLLLL==========================================================================

	elif [[ $actionVM == [lL] ]] ; then
echo "$(prlctl list -a | awk 'NR>1 {print S1="VM:\t\t"$5,$3="\t",$2}'| grep -n VM: | column -t | pr -t -2 )"

#kkkkkkkkkkkkkkkkkk=========================================================================

	elif [[ $actionVM == [kK] ]] ; then
read -p "Выберите шаблон ВМ для клонирования:" numVB
[[ $numVB =~ [Xx] ]] && continue

namelistVM="$(prlctl list -a | awk 'NR>1 {print S1="VM:\t\t"$5,$3="\t",$2}'| grep -n VM: | grep -w ^$numVB | awk '{print $2}')"
read -p "Укажите имена ВМ, через пробел (eXit):"  NameClonVM

#if [[ "$1" != [xX] ]] ; then

	for forvar2 in $NameClonVM
	do
prlctl clone $namelistVM --name $forvar2
	done
#else
#echo " "
#fi

#САПШЕТfffffffffff==========================================================================



#===========================================================================================

	elif [[ $actionVM == [Xx] ]] ; then
X=$actionVM
	else
echo "Не чего не выбрано:"
	fi
	done

