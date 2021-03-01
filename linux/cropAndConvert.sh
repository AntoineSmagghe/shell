#!/bin/bash
outputFileName=$(echo "$1" | cut -f 1 -d '.')-crop.mp4
ffmpeg -i $1 -filter:v "crop=1600:1150:1200:330" $outputFileName

./webmToGif.sh $outputFileName
