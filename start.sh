#!/bin/sh

desktop=0
daemon=0
    
    
    
status_node=$(ps -au | grep "java -jar qoober.jar" | grep -v grep | wc -l)
if [ $status_node -ge 1 ]
    then {
        echo 
        echo "QOOBER server is already running"
        echo "QOOBER сервер уже запущен"
        echo
        echo "To stop the server run the command ./stop.sh"
        echo "Для остановки используйте команду ./stop.sh"
        echo
        exit 1
        }
    else
        {
        help()
            {
            echo "Parameters:"
            echo "Для запуска :"
            echo
            echo "  Вариант 1"
            echo "  --desktop : Force desktop mode in the current directory."
            echo "              Для запуска в консоли запустите ./start.sh --desktop"
            echo "              Для остановки и выхода нажмите Ctrl+C"
            echo
            echo "  Вариант 2"
            echo "  --daemon  : Start in daemon mode (background). Use ./stop.sh to stop the node."
            echo "              Для запуска в бэкграунде запустите ./start.sh --daemon"
            echo "              Для остановки ноды запустите ./stop.sh"
            exit
            }

        while [ "$1" != "" ]; do
        case $1 in
            --desktop )    desktop=1
            ;;
            --daemon )     daemon=1
            ;;
            * )            help
            ;;
        esac
        shift
        done
        if [ $desktop -eq 1 ] && [ $daemon -eq 1 ]; 
            then {
            echo
            echo "You cannot run in desktop and daemon mode at the same time. Choose only one option"
            echo "Вы не можете запустить в desktop и daemon mode одновременно. Выбирите только один вариант."
            echo
            exit 1
            }
        fi;
        if [ -x jdk/bin/java ]
            then {
            JAVACMD=./jdk/bin/java
                }
            else
                {
                JAVACMD=java
                }
            fi;
        if [ $desktop -eq 1 ] 
            then {
                echo
                echo "Run the Desktop mode"
                echo "Запускаем в консоли"
                sleep 3
                ${JAVACMD} -jar qoober.jar
            }
        elif [ $daemon -eq 1 ]
            then {
                echo
                echo "Run the Daemon mode"
                echo "Запускаем в бэкграунд"
                echo
                cd ~/qoober-node/
                ${JAVACMD} -jar qoober.jar > /dev/null 2>&1 &
            }
            else
            {
                echo
                echo "Which mode do you want to run?"
                echo "В каком режиме вы хотите запустить?"
                echo
                ./start.sh help
            }
            fi;
    exit 1
    }
fi;
