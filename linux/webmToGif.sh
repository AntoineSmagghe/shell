#!/bin/bash

outputFileName=$(echo "$1" | cut -f 1 -d '.').gif
ffmpeg -i $1 -filter:v "fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $outputFileName
