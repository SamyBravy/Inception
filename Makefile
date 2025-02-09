#https://github.com/codesshaman/inception
#https://chatgpt.com/c/67a4da1c-8114-800c-a0e8-06fb72495948
#https://chatgpt.com/c/67a738f4-0cac-800c-871b-280181ff7b01
#https://chatgpt.com/c/67a886a4-a4c8-800c-b634-1f6b8f22e603

name = Inception

all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re:	down
	@printf "Rebuilding configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a --force
	@sudo rm -rf ~/data

fclean:
	@printf "Total cleaning of all docker configurations\n"
	@if [ $$(docker ps -qa | wc -l) -gt 0 ]; then docker stop $$(docker ps -qa); fi
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data

.PHONY	: all build down re clean fclean
