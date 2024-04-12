#!/bin/bash

output() {
	echo "Total number of folders (including all nested ones) = " $(find $path -type d | grep -v './$'| wc -l)

	folders=$(du -h $path | sort -rh | grep -v './$' | head -n 5)

	if [[ $folders == "" ]]; then 
		folders_count=0
	else
		folders_count=$(echo "$folders" | wc -l)
	fi

	if [[ $folders_count != 0 ]]; then 
		echo "TOP $folders_count folders of maximum size arranged in descending order (path and size):"
		
		counter=0
    echo "$folders" | while read -r line; do
        counter=$(expr $counter + 1)
        if [[ $counter -le $folders_count ]]; then
            folder=$(echo $line | awk '{print $2}')
            size=$(echo $line | awk '{print $1}')
            relative_path=$(realpath --relative-to="$path" "$folder")
            echo "$counter - $relative_path, $size"
        fi
    done
	fi

	files_count=$(find $path -type f | wc -l)
	echo
	echo "Total number of files = $files_count" 

	if [[ $files_count != 0 ]]; then
		echo "Number of:"
		echo "Configuration files (with the .conf extension) = " $(find $path -type f -name "*.conf" | wc -l)
		echo "Text files = " $(find $path -type f -exec file {} \; | grep -i "text" | wc -l)
		echo "Executable files = " $(find $path -type f -executable | wc -l)
		echo "Log files (with the extension .log) = " $(find $path -type f -name "*.log" | wc -l)
		echo "Archive files = " $(find $path -type f -name '*.zip' -o \
			-name '*.tar' -o \
			-name '*.tar.gz' -o \
			-name '*.tar.bz2' -o \
			-name '*.tar.xz' -o \
			-name '*.tgz' -o \
			-name '*.7z' | wc -l)
		echo "Symbolic links = " $(find $path -type l | wc -l)

		if [[ $files_count -gt 10 ]]; then 
			files_count=10
		fi
		echo
		echo "TOP $files_count files of maximum size arranged in descending order (path, size and type): "
		files=$(find $path -type f -exec du -h {} + | sort -rh | head -n 10)
		counter=0
    echo "$files" | while read -r line; do
        counter=$(expr $counter + 1)
        if [[ $counter -le $files_count ]]; then
					file=$(echo $line | awk '{print $2}')
					size=$(echo $line | awk '{print $1}')
					relative_path=$(realpath --relative-to="$path" "$file")
					file_extension=$(echo "$file" | awk -F. '{print $NF}')
        	echo "$counter - $relative_path, $size, $file_extension"
        fi
    done

		files_exec_count=$(find $path -type f -executable | wc -l)
		if [[ $files_exec_count -gt 10 ]]; then 
			files_exec_count=10
		fi

		if [[ $files_exec_count != 0 ]]; then
			echo
			echo "TOP $files_exec_count executable files of the maximum size arranged in descending order (path, size and MD5 hash of file): "
			files_exec=$(find $path -type f -executable -exec du -h {} + | sort -rh | head -n 10)
			counter=0
			echo "$files_exec" | while read -r line; do
					counter=$(expr $counter + 1)
					if [[ $counter -le $files_exec_count ]]; then
						file=$(echo $line | awk '{print $2}')
						size=$(echo $line | awk '{print $1}')
						relative_path=$(realpath --relative-to="$path" "$file")
						md5_hash=$(md5sum "$file" | awk '{print $1}')
       		 	echo "$counter - $relative_path, $size, $md5_hash"
					fi
			done
		fi
	fi
}
