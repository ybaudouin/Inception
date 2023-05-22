# Variables
PROJECT_NAME=inception
DOCKER_COMPOSE_FILE=./srcs/docker-compose.yml

# Build Docker images
build:
	@mkdir -p /home/zool/data
	@mkdir -p /home/zool/data/wordpress
	@mkdir -p /home/zool/data/mariadb
	@sudo docker-compose -f $(DOCKER_COMPOSE_FILE) build

# Start containers
up:
	@sudo docker-compose -f $(DOCKER_COMPOSE_FILE) up

# Stop containers
down:
	@sudo docker-compose -f $(DOCKER_COMPOSE_FILE) down

# Restart containers
restart:
	@sudo docker-compose -f $(DOCKER_COMPOSE_FILE) down
	@sudo docker-compose -f $(DOCKER_COMPOSE_FILE) up

# Clean
fclean: down
	@sudo rm -rf /home/zool/data/wordpress
	@sudo rm -rf /home/zool/data/mariadb
	@docker volume rm srcs_mariadb
	@docker volume rm srcs_wordpress
	@docker network prune
	@sudo docker system prune -af

# Show logs
logs:
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f