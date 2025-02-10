#https://github.com/codesshaman/inception
#https://chatgpt.com/c/67a4da1c-8114-800c-a0e8-06fb72495948
#https://chatgpt.com/c/67a738f4-0cac-800c-871b-280181ff7b01
#https://chatgpt.com/c/67a886a4-a4c8-800c-b634-1f6b8f22e603

name = Inception

all:
	echo "Launching configuration ${name}..."
	bash srcs/requirements/tools/make_dir.sh
	docker compose -f ./srcs/docker-compose.yml up -d

test: down
	echo "Launching configuration ${name}..."
	bash srcs/requirements/tools/make_dir.sh
	docker compose -f ./srcs/docker-compose.yml up --build

build:
	echo "Building configuration ${name}..."
	bash srcs/requirements/tools/make_dir.sh
	docker compose -f ./srcs/docker-compose.yml build

down:
	echo "Stopping configuration ${name}..."
	docker compose -f ./srcs/docker-compose.yml down

re: clean build all

clean:
	echo "Cleaning configuration ${name}..."
	docker-compose -f ./srcs/docker-compose.yml down --remove-orphans
	docker network prune -f
	docker volume prune -f

fclean:
	echo "Total cleaning of all docker configurations"
	docker-compose -f ./srcs/docker-compose.yml down --rmi all --volumes --remove-orphans
	docker image prune -a -f
	docker network prune -f
	docker volume prune -f
	sudo rm -rf ~/data

.PHONY	: all build down re clean fclean
.SILENT :
