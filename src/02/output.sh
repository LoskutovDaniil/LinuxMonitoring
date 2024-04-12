#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE=$(sudo timedatectl)
USER=$(whoami)
OS_TYPE=$(uname -s)
OS_VERSION=$(uname -r)
DATE=$(date +"%d %b %Y %H:%M:%S")
UPTIME=$(uptime)
uptime_sec=$(date -d "$(uptime -s)" +%s)
current_time=$(date +%s)
uptime_seconds=$((current_time - uptime_sec))
enp="$(ifconfig | grep -P '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' | grep -v '127.0.0.1')"
IP="$(echo $enp | awk '{print $2}')"
MASK="$(echo $enp | awk '{print $4}')"
GATEWAY="$(netstat -rn | grep -E '^(0\.0.\0.\0 | default)' | awk '{print $2}')"
MASK=$(ip -o -4 addr show | awk '{print $4}' | cut -d'/' -f2 | head -n1)
GATEWAY=$(ip route | awk '/default/ {print $3}')
RAM_TOTAL=$(free -m | awk '/Mem/ {printf "%.3f", $2/1024}')
RAM_USED=$(free -m | awk '/Mem/ {printf "%.3f", $3/1024}')
RAM_FREE=$(free -m | awk '/Mem/ {printf "%.3f", $4/1024}')
SPACE_ROOT=$(df -h / | awk '/dev/ {printf "%.2f", $2*1024}')
SPACE_ROOT_USED=$(df -h / | awk '/dev/ {printf "%.2f", $3*1024}')
SPACE_ROOT_FREE=$(df -h / | awk '/dev/ {printf "%.2f", $4*1024}')

output () {
echo "Имя хоста: $HOSTNAME"
echo "Временная зона: $TIMEZONE"
echo "USER: $USER"
echo "Тип операционной системы: $OS_TYPE"
echo "Версия операционной системы: $OS_VERSION"
echo "Текущее время: $DATE"
echo "Время работы системы: $UPTIME"
echo "Время работы системы в секундах: $uptime_seconds секунд"
echo IP = $IP
echo "MASK = $MASK"
echo "GATEWAY: $GATEWAY"
echo "RAM_TOTAL: $RAM_TOTAL GB"
echo "RAM_USED: $RAM_USED GB"
echo "RAM_FREE: $RAM_FREE GB"
echo "SPACE_ROOT: $SPACE_ROOT MB"
echo "SPACE_ROOT_USED: $SPACE_ROOT_USED MB"
echo "SPACE_ROOT_FREE: $SPACE_ROOT_FREE MB"
}