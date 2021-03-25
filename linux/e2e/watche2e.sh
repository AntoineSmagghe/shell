#!/bin/zsh
# Watch e2e behat tests with tags @debug

if ! which entr; then
	echo 'ERROR: entr is required !'
	echo 'You can get it with :\n'
	echo '	sudo apt install entr\n'
	exit
fi

projectFolder=$1

cd "$projectFolder"
find features | entr -s 'APP_ENV=e2e vendor/bin/behat --tags debug'
