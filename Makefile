inferno_docker_build:
	docker build -t inferno inferno
	
git_update:
	git submodule update --init --remote --merge

inferno_docker_rebuild:
	docker build --no-cache -t inferno inferno

inferno_clean_db:
	docker-compose down
	rm -f inferno/data/*.db
	docker-compose up -d

