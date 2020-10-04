#!/bin/bash
echo
echo "Устанавливаем mc, htop, git и java"
sudo apt-get update &>/dev/null
echo "...ожидаем минутку"
sudo apt-get install -y mc htop git default-jdk &>/dev/null
echo ""
# Переходим в домашний коталог
cd ~/
# Удаляем старые папки ноды
sudo rm -r ~/qoober-node  &>/dev/null
sudo rm -r ~/qoober-node-compiled  &>/dev/null

# Клонируем репозиторий QOOBER
git clone https://github.com/Qoober/qoober-node-compiled &>/dev/null
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
echo "qoober.myAddress=" >> ~/qoober-node/conf/qoober.properties
echo "qoober.myPlatform=" >> ~/qoober-node/conf/qoober.properties
echo "qoober.adminPassword=" >> ~/qoober-node/conf/qoober.properties

# Вставляем нужные параметры в файл конфига
perl -i -pe "s!qoober.myAddress=!qoober.myAddress=$my_ip!g" ~/qoober-node/conf/qoober.properties
perl -i -pe "s!qoober.myPlatform=!qoober.myPlatform=$nodaname!g" ~/qoober-node/conf/qoober.properties
perl -i -pe "s!qoober.adminPassword=!qoober.adminPassword=$nodapass!g" ~/qoober-node/conf/qoober.properties

# Скачиваем файлы для запуска/остановки ноды
cd ~/qoober-node/
wget https://raw.githubusercontent.com/club-coin/qoober-node/main/start.sh &>/dev/null
wget https://raw.githubusercontent.com/club-coin/qoober-node/main/stop.sh &>/dev/null
echo ""
echo "Устанавливаем права на запуск файла "
sleep 2
chmod 755 ~/qoober-node/run.sh
chmod 755 ~/qoober-node/start.sh
chmod 755 ~/qoober-node/stop.sh
echo ""

echo "Вы хотите видеть загрузку ноды? (y/n)"
echo ""
read item
case "$item" in
    y|Y) echo "Ввели «y», запуксаем в консоли..."
        sleep 2
        cd ~/qoober-node/
        ./start.sh --desktop
        ;;
    n|N) echo "Ввели «n», запускаем в бэкграунд..."
        sleep 2
        cd ~/qoober-node/
        ./start.sh --daemon &>/dev/null
        ;;
    *) echo "Ничего не ввели. Выполняем действие по умолчанию..."
        sleep 2
        cd ~/qoober-node/
        ./start.sh --desktop &>/dev/null
        ;;
esac


echo -n "Установка ноды завершена"
echo
exit 0
