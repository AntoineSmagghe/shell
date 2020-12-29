#!/bin/bash
# Execute function when file in folder change.
# how to execute : 
# ./watchFolder.sh </path/to/watch> <command>
#
# Require entr
#

while true; do find $1 | entr -pd $2; done
