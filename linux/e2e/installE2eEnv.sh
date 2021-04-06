#!/bin/bash

if ! which java; then
	echo 'ERROR: Java is required !'
	echo 'You can get it with :\n'
	echo '	sudo apt install default-jre\n'
	exit
fi

if ! which symfony; then
	echo 'ERROR: Symfony is required !'
	echo 'You can get it with :\n'
	echo '	wget https://get.symfony.com/cli/installer -O - | bash\n'
	exit
fi

if ! which google-chrome; then
	echo 'ERROR: Google chrome is required !'
	echo 'You can get it with :\n'
	echo '	sudo apt install google-chrome-stable'
	exit
fi

if [ ! -d "~/.local/.e2e-tmp" ]; then
	mkdir -p ~/.local/.e2e-tmp
	cd ~/.local/.e2e-tmp/

	google-chrome --version | awk '{print $3}' > google-version.txt
	googleVersion=$(cat google-version.txt)

	curl -o selenium.jar -O http://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
	curl -o chromedriver.zip -O https://chromedriver.storage.googleapis.com/89.0.4389.23/chromedriver_linux64.zip
	# curl -o chromedriver.zip -O https://chromedriver.storage.googleapis.com/"$googleVersion"/chromedriver_linux64.zip
	unzip chromedriver.zip
	rm chromedriver.zip
fi
