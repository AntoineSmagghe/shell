#!/bin/bash
cd ..

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

if [ ! -d "api/vendor/.e2e-tmp" ]; then
	mkdir -p api/vendor/.e2e-tmp
	cd api/vendor/.e2e-tmp/

	google-chrome --version | awk '{print $3}' > google-version.txt
	googleVersion=$(cat google-version.txt)

	curl -o selenium.jar -O http://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
	curl -o chromedriver.zip -O https://chromedriver.storage.googleapis.com/"$googleVersion"/chromedriver_linux64.zip
	unzip chromedriver.zip
	rm chromedriver.zip
	cd ../../../
fi

docker-compose up -d

cd client
npm run build
make start &
sleep 15

cd ../api
symfony server:stop
APP_ENV=test symfony server:start --allow-http -d
sleep 5

cd vendor/.e2e-tmp && java -Dwebdriver.chromedriver=chromedriver -jar selenium.jar &
sleep 5

./vendor/bin/behat

# kill processes
symfony server:stop
symfony server:start --allow-http -d
pkill node
pkill java

