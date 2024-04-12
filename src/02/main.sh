#!/bin/bash

source ./output.sh

if [[ $# != 0 ]]; then
  echo "Пожалуйста, не вводите параметры"
  exit 1
fi

HOSTNAME=$(hostname)
echo "Имя хоста: $HOSTNAME"

TIMEZONE=$(sudo timedatectl)
echo "Временная зона: $TIMEZONE"

USER=$(whoami)
echo "USER: $USER"

OS_TYPE=$(uname -s)
OS_VERSION=$(uname -r)
echo "Тип операционной системы: $OS_TYPE"
echo "Версия операционной системы: $OS_VERSION"

DATE=$(date +"%d %b %Y %H:%M:%S")
echo "Текущее время: $DATE"

UPTIME=$(uptime)
echo "Время работы системы: $UPTIME"

uptime_sec=$(date -d "$(uptime -s)" +%s)
current_time=$(date +%s)
uptime_seconds=$((current_time - uptime_sec))
echo "Время работы системы в секундах: $uptime_seconds секунд"

enp="$(ifconfig | grep -P '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' | grep -v '127.0.0.1')"
IP="$(echo $enp | awk '{print $2}')"
MASK="$(echo $enp | awk '{print $4}')"
GATEWAY="$(netstat -rn | grep -E '^(0\.0.\0.\0 | default)' | awk '{print $2}')"
echo IP = $IP

MASK=$(ip -o -4 addr show | awk '{print $4}' | cut -d'/' -f2 | head -n1)
echo "MASK = $MASK"

GATEWAY=$(ip route | awk '/default/ {print $3}')
echo "GATEWAY: $GATEWAY"

RAM_TOTAL=$(free -m | awk '/Mem/ {printf "%.3f", $2/1024}')
echo "RAM_TOTAL: $RAM_TOTAL GB"

RAM_USED=$(free -m | awk '/Mem/ {printf "%.3f", $3/1024}')
echo "RAM_USED: $RAM_USED GB"

RAM_FREE=$(free -m | awk '/Mem/ {printf "%.3f", $4/1024}')
echo "RAM_FREE: $RAM_FREE GB"

SPACE_ROOT=$(df -h / | awk '/dev/ {printf "%.2f", $2*1024}')
echo "SPACE_ROOT: $SPACE_ROOT MB"

SPACE_ROOT_USED=$(df -h / | awk '/dev/ {printf "%.2f", $3*1024}')
echo "SPACE_ROOT_USED: $SPACE_ROOT_USED MB"

SPACE_ROOT_FREE=$(df -h / | awk '/dev/ {printf "%.2f", $4*1024}')
echo "SPACE_ROOT_FREE: $SPACE_ROOT_FREE MB"

echo "Записать эти данные в файл? Y/N"
read result

if [ -n "$result" ]; then
    if [ "$result" == "y" ] || [ "$result" == "Y" ]; then
        file_datetime="$(date +"%d_%m_%y_%H_%M_%S").status"
        output > $file_datetime
        echo "Данные сохранены в файл $file_datetime"
    else
        exit 1
    fi
else
    echo "Параметр не найден"
fi
