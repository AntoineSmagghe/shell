help: ## Generate a help message with this comment on each commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

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
	cd ~/Documents/vimeet365/api && APP_ENV=e2e symfony server:start --allow-http -d

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
	cd ~/Documents/vimeet365/api && symfony server:start --allow-http -d

stop-e2e.docker:
	cd ~/Documents/vimeet365 && docker-compose down
	sed -i 's/proximum_vimeet365_test/proximum_vimeet365/' ~/Documents/vimeet365/docker-compose.yaml
	cd ~/Documents/vimeet365 && docker-compose up -d

watch-e2e: ## Watch folder for e2e tests
	./watche2e.sh ~/Documents/vimeet365/api ~/Documents/vimeet365/api/features
