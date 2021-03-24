help: ## Generate a help message with this comment on each commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install-e2e: ## Download and install e2e test environnement
	./installE2eEnv.sh

start-e2e: ## Build the environnemnt to launch tests locally
	cd ~/Documents/vimeet365 && docker-compose down
	sed -i -e 's/proximum_vimeet365$$/proximum_vimeet365_test/' ~/Documents/vimeet365/docker-compose.yaml
	cd ~/Documents/vimeet365 && docker-compose up -d
	cd ~/Documents/vimeet365/api && symfony server:stop
	cd ~/Documents/vimeet365/api && APP_ENV=e2e symfony server:start --allow-http -d
	cd ~/.local/.e2e-tmp && java -Dwebdriver.chromedriver=chromedriver -jar selenium.jar
	#-port 8080

stop-e2e: ## Stop the symfony server test env
	cd ~/Documents/vimeet365/api && symfony server:stop
	cd ~/Documents/vimeet365/api && symfony server:start --allow-http -d
	cd ~/Documents/vimeet365 && docker-compose down
	sed -i 's/proximum_vimeet365_test/proximum_vimeet365/' ~/Documents/vimeet365/docker-compose.yaml
	cd ~/Documents/vimeet365 && docker-compose up -d
