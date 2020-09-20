#!/bin/bash

while [ -n "$1" ]
do
    case $1 in
        "-h" | "-help" ) 
            echo "Авторы:"
            echo "Перов Артем ис-841"
            echo ""
            echo "Доступные аргументы:" 
            echo -e "-h или -help\t\t помощь"
            echo -e "-example\t\t примеры использования команд"
            echo -e "-i или -interface\t вывод сетевых интерфейсов"
            echo -e "-u или -up\t\t включение сетевых интерфейсов"
            echo -e "-d или -down\t\t выключение сетевых интерфейсов"
            echo -e "-ip\t\t\t установка ip"
            echo -e "-mask\t\t\t установка mask"
            echo -e "-gateway или -gw\t установка Gateway"
            echo -e "-nmap_site\t\t карта сети для сайта"
            echo -e "-nmap_loc\t\t карта сети для ip"
            echo -e "-kill\t\t\t убийство процесса по занимаемому порту"
            ;;
        "-example")
            echo -e "-h -help\tпояснение не требуется:)"
            echo -e "-i\t\tиспользуется без аргументов"
            echo -e "-u\t\t./lab_1.sh -u ens33 lo (включает два интерфейса)"
            echo -e "-u\t\t./lab_1.sh -d ens33 lo (выключает два интерфейса)"
            echo -e "-ip\t\t./lab_1.sh -ip ens 192.168.31.5 (устанавливает указанный ip для указанного интерфейса)"
            echo -e "-mask\t\t./lab_1.sh -mask ens 192.168.31.5 (устанавливает указанный mask для указанного интерфейса)"
            echo -e "-gw\t\t./lab_1.sh -gw 192.168.132.15 (устанавливать gateway на указанный)"
            echo -e "-nmap_site\t./lab_1.sh -nmap_site google.com (карта сети для указанного сайта)"
            echo -e "-nmap_loc\t./lab_1.sh -nmap_loc 192.168.0.1 (карта сети для указанного ip)"
            echo -e "-kill\t\t./lab_1.sh -kill 8080 (показ и выбор процесса для его убийства)"
        ;;
        "-i" | "-interface")
            ifconfig -a
        ;;
        "-u" | "-up")
            shift
            a=0
            for i in $@
            do
                a=$(($a+1))
                if 
                    [ "$i" == "-h" ] || [ "$i" == "-help" ] || [ "$i" == "-i" ] || [ "$i" == "-interface" ] || 
                    [ "$i" == "-u" ] || [ "$i" == "-up" ] || [ "$i" == "-d" ] || [ "$i" == "-down" ] || 
                    [ "$i" == "-ip" ] || [ "$i" == "-mask" ] || [ "$i" == "-gate" ] || [ "$i" == "-nmap_loc" ] || 
                    [ "$i" == "-gate" ] || [ "$i" == "-example" ]
                then  
                    break
                fi
            done
        #-1
            b=$(($a-1))
        
            for (( i=1; i<a; i++ ))
            do   
        
                ifconfig $1 up
        
                if [ "$i" -lt "$b" ] 
                then
                    shift
                fi
            done  
            echo "готово"   
        ;;
        "-d" | "-down")
            shift
            a=0
            for i in $@
            do
                a=$(($a+1))
                if 
                    [ "$i" == "-h" ] || [ "$i" == "-help" ] || [ "$i" == "-i" ] || [ "$i" == "-interface" ] || 
                    [ "$i" == "-u" ] || [ "$i" == "-up" ] || [ "$i" == "-d" ] || [ "$i" == "-down" ] || 
                    [ "$i" == "-ip" ] || [ "$i" == "-mask" ] || [ "$i" == "-gate" ] || [ "$i" == "-nmap_loc" ] || 
                    [ "$i" == "-gate" ] || [ "$i" == "-example" ]
                then 
                    break
                fi
            done
        
            b=$(($a-1))
        
            for (( i=1; i<a; i++ ))
            do        
                ifconfig $1 down    
                if [ "$i" -lt "$b" ] 
                then
                    shift
                fi
            done  
            echo "готово"   
            ;;
        
        "-ip")
            shift
            if [[ ${1} == "" ]]
            then
                echo "а куда записывать?"
                break
            fi
            echo "Введите ip: "
                read ip;
                ifconfig ${1} ${ip}
        ;;
        "-mask")
        shift
            if [[ ${1} == "" ]]
            then
                echo "а куда записывать?"
                break
            fi
            echo "Введите mask: "
                read mask;
                ifconfig ${1} netmask ${mask}
        ;;
        "-gateway" | "-gw")
        shift
            if [[ ${1} == "" ]]
            then
                echo "а что записывать?"
                break
            else 
                ip route delete default
                ip roude add default via $1
            fi
                
        ;;
        "-nmap_loc")    
            shift
            nmap -v -sP $1/24
        ;;
        -"-nmap_site")
            shift
            nmap -v -A "$1"
        ;;
        "-kill")
            shift
            sudo netstat -lpn |grep :$1
            echo "Введите id процесса (последний столбец-цифра)"
                read id
                sudo kill "$id"
        ;;
        *)
            echo -e "Команда не найдена.\nИспользуйте -help или -h"
        esac
    shift
done
