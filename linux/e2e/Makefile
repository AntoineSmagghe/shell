.SILENT:
.PHONY: help

## Folders
SERVER_FOLDER = ~/Documents/vimeet365/server

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-19s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Download and install e2e test environnement
install-e2e:
	./installE2eEnv.sh

## Create the test database for e2e tests
install-database: 
	make start-e2e.docker
	make start-e2e.symfony
	cd ${SERVER_FOLDER} && APP_ENV=e2e php bin/console doctrine:database:create
	cd ${SERVER_FOLDER} && APP_ENV=e2e php bin/console doctrine:migrations:migrate
	make stop-e2e.symfony
	make stop-e2e.docker

## Purge and recreate database schema with env e2e
purge-database:
	make start-e2e.symfony
	cd ${SERVER_FOLDER} && APP_ENV=e2e php bin/console doctrine:schema:drop --force
	cd ${SERVER_FOLDER} && APP_ENV=e2e php bin/console doctrine:schema:create

## Build the environnemnt to launch tests locally
start-e2e:
	make start-e2e.docker
	make start-e2e.symfony
	make start-e2e.chromedriver

start-e2e.docker:
	cd ${SERVER_FOLDER} && docker-compose up -d

start-e2e.symfony:
	cd ${SERVER_FOLDER} && symfony server:stop
	cd ${SERVER_FOLDER} && symfony proxy:stop
	cd ${SERVER_FOLDER} && APP_ENV=e2e symfony proxy:start
	cd ${SERVER_FOLDER} && APP_ENV=e2e symfony server:start --allow-http --port 8365 -d

start-e2e.chromedriver:
	cd ~/.local/.e2e-tmp && java -Dwebdriver.chromedriver=chromedriver -jar selenium.jar

## Stop the symfony server test env
stop-e2e:
	make stop-e2e.symfony
	# make stop-e2e.docker

stop-e2e.symfony:
	cd ${SERVER_FOLDER} && symfony server:stop
	cd ${SERVER_FOLDER} && symfony proxy:stop
	cd ${SERVER_FOLDER} && symfony proxy:start
	cd ${SERVER_FOLDER} && symfony server:start --allow-http --port 8365 -d

stop-e2e.docker:
	cd ~/Documents/vimeet365 && docker-compose down
	sed -i 's/proximum_vimeet365_test/proximum_vimeet365/' ~/Documents/vimeet365/docker-compose.yaml
	cd ~/Documents/vimeet365 && docker-compose up -d

## Watch folder for e2e tests
watch-e2e:
	cd ${SERVER_FOLDER} && find ${SERVER_FOLDER}/features | entr -s 'APP_ENV=e2e vendor/bin/behat --tags debug'
#./watche2e.sh ${SERVER_FOLDER} ${SERVER_FOLDER}/features

e2e:
	cd ${SERVER_FOLDER} && APP_ENV=e2e vendor/bin/behat
