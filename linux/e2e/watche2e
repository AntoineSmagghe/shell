#!/bin/zsh
# Watch e2e behat tests with tags @debug
# How to use : 
# ./watche2e.sh <PATH project folder> <PATH Folder to watch>

if ! which entr; then
	echo 'ERROR: entr is required !'
	echo 'You can get it with :\n'
	echo '	sudo apt install entr\n'
	exit
fi

projectFolder=$1
cd $projectFolder

folderToWatch=$2
find $folderToWatch | entr -s 'APP_ENV=e2e vendor/bin/behat --tags debug'
