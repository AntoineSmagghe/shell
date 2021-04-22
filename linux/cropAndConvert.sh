#!/bin/bash
outputMp4=${1%.*}-crop.mp4
ffmpeg -i $1 -filter:v "crop=1860:1130:1350:330" $outputMp4

outputGif=$(echo "$outputMp4" | cut -f 1 -d '.').gif
ffmpeg -i $outputMp4 -filter:v "fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $outputGif

rm "$outputMp4"
xdg-open "$outputGif"
