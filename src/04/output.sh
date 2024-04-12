#!/bin/bash

check_colors_variable () {   
    variable_name="$1"
    default_value="$2"

    if grep -q "^$variable_name=" "colors.txt"; then
        return 0;
    else
        return 1;
    fi
}

parser1 () {
    if [[ $1 != [1-6] ]]; then
    echo "Ошибка! Вы ввели не цифру или цифру > 6 или 1 < ! Введите цифру."
    exit 1
    else
        case "$1" in
        1) fon_first=107 ;;
        2) fon_first=101 ;;
        3) fon_first=102 ;;
        4) fon_first=106 ;;
        5) fon_first=105 ;;
        6) fon_first=40 ;;
        esac
    fi
}

parser2 () {
    if [[ $1 != [1-6] ]]; then
    echo "Ошибка! Вы ввели не цифру или цифру > 6 или 1 <! Введите цифру."
    exit 1
    else
        case "$1" in
        1) text_first=97 ;;
        2) text_first=91 ;;
        3) text_first=92 ;;
        4) text_first=96 ;;
        5) text_first=95 ;;
        6) text_first=30 ;;
        esac
    fi
}

parser3 () {
    if [[ $1 != [1-6] ]]; then
    echo "Ошибка! Вы ввели не цифру или цифру > 6 или 1 < ! Введите цифру."
    exit 1
    else
        case "$1" in
        1) fon_second=107 ;;
        2) fon_second=101 ;;
        3) fon_second=102 ;;
        4) fon_second=106 ;;
        5) fon_second=105 ;;
        6) fon_second=40 ;;
        esac
    fi
}

parser4 () {
    if [[ $1 != [1-6] ]]; then
    echo "Ошибка! Вы ввели не цифру или цифру > 6 или 1 < ! Введите цифру."
    exit 1
    else
        case "$1" in
        1) text_second=97 ;;
        2) text_second=91 ;;
        3) text_second=92 ;;
        4) text_second=96 ;;
        5) text_second=95 ;;
        6) text_second=30 ;;
        esac
    fi
}

parser_color () {
    case "$1" in
    1) echo "white" ;;
    2) echo "red" ;;
    3) echo "green" ;;
    4) echo "blue" ;;
    5) echo "purple" ;;
    6) echo "black" ;;
    esac
}

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
echo -e "\033[${fon_first};${text_first}mHOSTNAME=\033[${fon_second};${text_second}m$HOSTNAME\033[0m"
echo -e "\033[${fon_first};${text_first}mTIMEZONE=\033[${fon_second};${text_second}m$TIMEZONE\033[0m"
echo -e "\033[${fon_first};${text_first}mUSER=\033[${fon_second};${text_second}m$USER\033[0m"
echo -e "\033[${fon_first};${text_first}mOS_TYPE=\033[${fon_second};${text_second}m$OS_TYPE\033[0m"
echo -e "\033[${fon_first};${text_first}mOS_VERSION=\033[${fon_second};${text_second}m$OS_VERSION\033[0m"
echo -e "\033[${fon_first};${text_first}mDATE=\033[${fon_second};${text_second}m$DATE\033[0m"
echo -e "\033[${fon_first};${text_first}mUPTIME=\033[${fon_second};${text_second}m$UPTIME\033[0m"
echo -e "\033[${fon_first};${text_first}mUPTIME_SECONDS=\033[${fon_second};${text_second}m$uptime_seconds\033[0m"
echo -e "\033[${fon_first};${text_first}mIP=\033[${fon_second};${text_second}m$IP\033[0m"
echo -e "\033[${fon_first};${text_first}mMASK=\033[${fon_second};${text_second}m$MASK\033[0m"
echo -e "\033[${fon_first};${text_first}mGATEWAY=\033[${fon_second};${text_second}m$GATEWAY\033[0m"
echo -e "\033[${fon_first};${text_first}mRAM_TOTAL=\033[${fon_second};${text_second}m$RAM_TOTAL GB\033[0m"
echo -e "\033[${fon_first};${text_first}mRAM_USED=\033[${fon_second};${text_second}m$RAM_USED GB\033[0m"
echo -e "\033[${fon_first};${text_first}mRAM_FREE=\033[${fon_second};${text_second}m$RAM_FREE GB\033[0m"
echo -e "\033[${fon_first};${text_first}mSPACE_ROOT=\033[${fon_second};${text_second}m$SPACE_ROOT GB\033[0m"
echo -e "\033[${fon_first};${text_first}mSPACE_ROOT=\033[${fon_second};${text_second}m$SPACE_ROOT MB\033[0m"
echo -e "\033[${fon_first};${text_first}mSPACE_ROOT_USED=\033[${fon_second};${text_second}m$SPACE_ROOT_USED MB\033[0m"
echo -e "\033[${fon_first};${text_first}mSPACE_ROOT_FREE=\033[${fon_second};${text_second}m$SPACE_ROOT_FREE MB\033[0m"
}
