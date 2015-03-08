#!/bin/bash

path=$1
filename=$2
fps=$3

cd "${path}"

ls -1tr > files.txt

mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:autoaspect:vqscale=3 -vf scale=1920:1080 -mf type=jpeg:fps="${fps}" mf://@files.txt -o "${filename}"

rm files.txt
