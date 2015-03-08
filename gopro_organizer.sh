#!/usr/bin/env bash

pathtooriginalfiles=$1
pathtotarget=$2


# Chaptered images
mkdir -p "${pathtotarget}"/images-seq

for file in $(find "${pathtooriginalfiles}" -type f -regextype sed -regex ".*/G[0-9]\{7\}\.JPG"); do

    chapter=$(echo ${file} | sed 's/.*G\([0-9]\{3\}\)[0-9]\{4\}\.JPG/\1/')
    filename=$(basename ${file})

    newpath="${pathtotarget}"/images-seq/"${chapter}"/

    echo "Moving ${file} to: ${newpath}"

    mkdir -p "${newpath}"
    rsync -avzh -q --ignore-existing "${file}" "${newpath}"
done

# Chaptered videos
mkdir -p "${pathtotarget}"/videos-seq

for file in $(find "${pathtooriginalfiles}" -type f -regextype sed -regex ".*/GP[0-9]\{6\}\.MP4"); do

    chapter=$(echo ${file} | sed 's/.*GP\([0-9]\{2\}\)[0-9]\{4\}\.MP4/\1/')
    filename=$(basename ${file})

    newpath="${pathtotarget}"/videos-seq/"${chapter}"/

    echo "Moving ${file} to: ${newpath}"

    mkdir -p "${newpath}"
    rsync -avzh -q --ignore-existing "${file}" "${newpath}"
done


#find "${pathtooriginalfiles}" -name "*.THM" -o -name "*.LRV" -delete -exec echo Deleting {} \;

mkdir -p "${pathtotarget}"/images
mkdir -p "${pathtotarget}"/videos

# Images
find "${pathtooriginalfiles}" -type f -regextype sed -regex ".*/GOPR[0-9]\{4\}\.JPG" -exec echo Moving {} to "${pathtotarget}"/images \; -exec rsync -avzh --ignore-existing {} "${pathtotarget}"/images \;

#Videos
find "${pathtooriginalfiles}" -type f -regextype sed -regex ".*/GOPR[0-9]\{4\}\.MP4" -exec echo Moving {} to "${pathtotarget}"/videos \; -exec rsync --progress --ignore-existing -avzh {} "${pathtotarget}"/videos \;
#find $pathtooriginalfiles -regextype sed -regex ".*/G[0-9]\{7\}\.JPG" -printf "%f\n" | sed 's/G\([0-9]\{3\}\)[0-9]\{4\}\.JPG$/\1/' | xargs -I{} -n 1 echo mkdir -p $pathtotarget/{}

