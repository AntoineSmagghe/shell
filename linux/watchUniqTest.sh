#!/bin/sh

folderToWatch = $1
testToWatch = $2

find "$folderToWatch" | entr -s \'bin/phpunit --filter "$testToWatch"\'
