#!/bin/bash
# crop with 2 screen : 1860:980:1350:100
# crop with 3 screen : 1860:1130:1350:330
# command to resize with ffplay : ffplay -i inputfilename -vf crop=innerWidth:innerHeight:x:y
#

outputMp4=$(echo "$1" | cut -f 1 -d '.')-crop.mp4
ffmpeg -i $1 -filter:v "crop=1860:980:1350:100" $outputMp4

xdg-open "$outputMp4"
