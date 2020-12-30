#!/bin/bash
# Execute function when file in folder change.
# how to execute : 
# ./watchFolder.sh </path/to/watch> <path or ssh address to mirror copy>
#
# Require entr
#

# while true; do find $1 | entr -pd $2; done

echo "Files to watch:" $1
echo "Folder to synchronise:" $2

while true; do find $1 | entr -pd rsync -avz $1 $2; done

# exemple :
# while true; do find ./* | entr -pd rsync -avz ./* antoine@julybrisson.com:files; done