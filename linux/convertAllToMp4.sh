#!/bin/zsh

extensionToConvert=$1

for file in *.$extensionToConvert; do
    ffmpeg -i $file -c:v copy -c:a copy ${file%.*}.mp4
done
