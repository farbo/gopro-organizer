#!/bin/bash
path=$1

for file in $(find "${path}" -type f -name "*.MP4"); do
    fps=$(ffmpeg -i "${file}" 2>&1 | grep -o '[0-9\.]\{1,\}\sfps' | sed 's/\sfps//')
    
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename=$(dirname "${file}")/"${filename%.*}"_"${fps}"fps."${extension}"

    echo Renaming "${file}" to "${filename}"
    mv "${file}" "${filename}"
done

