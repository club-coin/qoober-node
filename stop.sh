#!/bin/sh
# проеряем запущена ли нода
status_node=$(ps -au | grep "java -jar qoober.jar" | grep -v grep | wc -l)
    if [ $status_node -eq 0 ]
    then {
        echo
        echo "QOOBER server is not runing"
        echo "QOOBER сервер НЕ запущен"
        echo
# И выходим        
        exit 1
        }
    else
    {
# Иначе пишем в консоли
        echo
        echo "stopping"
        echo "останавливаем"
        echo
# Убиваем процес ноды
        kill `ps -au | grep "java -jar qoober.jar" | grep -v grep | awk '{print $2}'` > /dev/null
# Ожидаем 5 секунд
        sleep 5
# И снова проверяем процесс ноды
        echo
        echo "Qoober server stopped"
        echo "Qoober сервер остановлен"
        echo
        exit 1
        }
    fi;
