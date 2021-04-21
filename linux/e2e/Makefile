## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

install-e2e: ## Download and install e2e test environnement
	./installE2eEnv.sh

install-database: ## Create the test database for e2e tests
	make start-e2e.docker
	make start-e2e.symfony
	cd ~/Documents/vimeet365/api && APP_ENV=e2e php bin/console doctrine:database:create
	cd ~/Documents/vimeet365/api && APP_ENV=e2e php bin/console doctrine:migrations:migrate
	make stop-e2e.symfony
	make stop-e2e.docker

purge-database:
	make start-e2e.symfony
	cd ~/Documents/vimeet365/api && APP_ENV=e2e php bin/console doctrine:schema:drop --force
	cd ~/Documents/vimeet365/api && APP_ENV=e2e php bin/console doctrine:schema:create

start-e2e: ## Build the environnemnt to launch tests locally
	make start-e2e.symfony
	make start-e2e.chromedriver

start-e2e.docker:
	cd ~/Documents/vimeet365 && docker-compose down
	sed -i -e 's/proximum_vimeet365$$/proximum_vimeet365_test/' ~/Documents/vimeet365/docker-compose.yaml
	cd ~/Documents/vimeet365 && docker-compose up -d

start-e2e.symfony:
	cd ~/Documents/vimeet365/api && symfony server:stop
	cd ~/Documents/vimeet365/api && symfony proxy:stop
	cd ~/Documents/vimeet365/api && APP_ENV=e2e symfony proxy:start
	cd ~/Documents/vimeet365/api && APP_ENV=e2e symfony server:start --allow-http --port 8365 -d

start-e2e.chromedriver:
	cd ~/.local/.e2e-tmp && java -Dwebdriver.chromedriver=chromedriver -jar selenium.jar
	#-port 8080

stop-e2e: ## Stop the symfony server test env
	make stop-e2e.symfony
	# make stop-e2e.docker

stop-e2e.symfony:
	cd ~/Documents/vimeet365/api && symfony server:stop
	cd ~/Documents/vimeet365/api && symfony proxy:stop
	cd ~/Documents/vimeet365/api && symfony proxy:start
	cd ~/Documents/vimeet365/api && symfony server:start --allow-http --port 8365 -d

stop-e2e.docker:
	cd ~/Documents/vimeet365 && docker-compose down
	sed -i 's/proximum_vimeet365_test/proximum_vimeet365/' ~/Documents/vimeet365/docker-compose.yaml
	cd ~/Documents/vimeet365 && docker-compose up -d

watch-e2e: ## Watch folder for e2e tests
	./watche2e.sh ~/Documents/vimeet365/api ~/Documents/vimeet365/api/features
