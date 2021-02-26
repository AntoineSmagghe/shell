#!/bin/bash

outputFileName=$(echo "$1" | cut -f 1 -d '.').gif
ffmpeg -i $1 -pix_fmt rgb8 $outputFileName
