NAME = inception
DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	mkdir -p $(HOME)/data/mariadb/
	mkdir -p $(HOME)/data/wordpress/
	$(DOCKER_COMPOSE) up -d --build

down:
	$(DOCKER_COMPOSE) down

start:
	$(DOCKER_COMPOSE) start

stop:
	$(DOCKER_COMPOSE) stop


clean: down

fclean: clean
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
	docker run --rm -v $(HOME)/data:/data debian:bookworm-slim bash -c "rm -rf /data/*" 2>/dev/null || true
	docker system prune -af
	rm -rf $(HOME)/data/
re: fclean all

.PHONY: all clean fclean re
