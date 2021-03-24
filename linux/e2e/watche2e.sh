#!/bin/zsh
# Watch e2e behat tests with tags @debug

projectFolder=$1

cd "$projectFolder"
find features | entr -s 'APP_ENV=e2e vendor/bin/behat --tags debug'
