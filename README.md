# Автоматическая установка ноды QOOBER 
 
## Скрипт для Ubuntu

Для автоматической установки введите следующие 3 команды в консоли сервера

```shell
wget https://raw.githubusercontent.com/club-coin/qoober-node/master/setup_node.sh
```
```shell
chmod 775 ./setup_node.sh
```
```shell
./setup_node.sh
```

Для остановки ноды используем команды

получаем номер процеса 
```shell
ps -A | grep java
```
и после убиваем сам процесс
```shell
kill -s 9 номер_процесса
```

Для повторного запуска в бэкгрануде используем файл run.sh
```shell
./run.sh
```
Для запуска в консоли, используем команду
```shell
java  -jar ~/qoober-node/qoober.jar
```




###
Telegram - https://t.me/forgery_qoobe
