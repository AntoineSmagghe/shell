#!/bin/bash
# Execute function when file in folder change.
# how to execute : 
# ./watchFolder.sh </path/to/watch> <path or ssh address to mirror copy>
#
# Require entr
#

echo "Folder to watch:" $1
echo "Folder to synchronise:" $2

rsync -avz $2 $1

while true; do 
    find "$1/*" | entr -pd rsync -avz $1 $2
done

# Exemple 1 :
# while true; do find ./* | entr -pd rsync -avz ./* antoine@julybrisson.com:files; done

# Exemple 2 (Synchronise the current folder to ssh antoine@julybrisson.com:files/): 
# rsync -avz --delete-after antoine@julybrisson.com:files/ .
# while true; do 
#     find ./* | entr -pd rsync -avz --delete-after . antoine@julybrisson.com:files
# done