#!/bin/bash

echo "Устанавливаем mc, htop, git и java"
sudo apt-get update 2>&1 >/dev/null
sudo apt-get install -y mc htop git default-jdk 2>&1 >/dev/null
echo ""
# Переходим в домашний коталог
cd ~/
# Удаляем старые папки ноды
sudo rm -r ~/qoober-node  2>/dev/null
sudo rm -r ~/qoober-node-compiled  2>/dev/null

# Клонируем репозиторий QOOBER
git clone https://github.com/Qoober/qoober-node-compiled
# Переименовываем папки
mv qoober-node-compiled qoober-node
# Создаем папку logs
mkdir ~/qoober-node/logs
echo "Создаем файл настроек"
echo ""
sleep 2
touch ~/qoober-node/conf/qoober.properties

echo "Задайте название ноды латиницей:"
read nodaname
echo ""
echo "Задайте пароль для ноды:"
read nodapass

# Узнаем внешний ип адрес
my_ip=$(curl smart-ip.net/myip)

# Вписываем ип адрес название ноды и пароль в файл настроек
# echo "qoober.myAddress=" >> ~/qoober-node/conf/qoober.properties
echo "qoober.myPlatform=" >> ~/qoober-node/conf/qoober.properties
echo "qoober.adminPassword=" >> ~/qoober-node/conf/qoober.properties

# Вставляем нужные параметры в файл конфига
perl -i -pe "s!qoober.myAddress=!qoober.myAddress=$my_ip!g" ~/qoober-node/conf/qoober.properties
perl -i -pe "s!qoober.myPlatform=!qoober.myPlatform=$nodaname!g" ~/qoober-node/conf/qoober.properties
perl -i -pe "s!qoober.adminPassword=!qoober.adminPassword=$nodapass!g" ~/qoober-node/conf/qoober.properties
echo ""
echo "Устанавливаем права на запуск файла "
sleep 2
chmod 755 ~/qoober-node/run.sh
echo ""

echo "Вы хотите видеть загрузку ноды? (y/n)"
echo ""
read item
case "$item" in
    y|Y) echo "Ввели «y», запуксаем в консоли..."
        sleep 2
        cd ~/qoober-node/
        java -jar qoober.jar
        ;;
    n|N) echo "Ввели «n», запускаем в бэкграунд..."
        sleep 2
        cd ~/qoober-node/
        java  -jar qoober.jar > /dev/null 2>&1
        ;;
    *) echo "Ничего не ввели. Выполняем действие по умолчанию..."
        sleep 2
        cd ~/qoober-node/
        java  -jar qoober.jar > /dev/null 2>&1
        ;;
esac


echo -n "Установка ноды завершена"
exit 0
