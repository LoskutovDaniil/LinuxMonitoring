#!/bin/bash

. ./output.sh

start_time=$(date +%s.%N)

if [[ $# == 0 ]]; then
	echo "Пожалуйста, укажите путь до папки. Путь должен заканчиваться знаком '/'"
elif [[ $# > 1 ]]; then
	echo "Пожалуйста, укажите один путь до папки. Путь должен заканчиваться знаком '/'"
else
	path=$1
	if [[ "${path: -1}" == '/' ]]; then
		if [[ -d $path ]]; then
			output
			execution_time=$(echo "$(date +%s.%N) - $start_time" | bc -l)
			echo
			echo "Script execution time (in seconds) = $(printf "%.2f" "$execution_time")"
		else
			echo "Папки не существует"
		fi
	else
		echo "Путь папки должен заканчиваться знаком '/'"
	fi
fi
