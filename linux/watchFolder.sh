#!/bin/bash
# Execute function when file in folder change.
# how to execute : 
# ./watchFolder.sh </path/to/watch> <path or ssh address to mirror copy>
#
# Require entr
#

while true; do find $1 | entr -pd $2; done

# exemple :
# while true; do find ./* | entr -pd rsync -avz ./* antoine@julybrisson.com:files; done