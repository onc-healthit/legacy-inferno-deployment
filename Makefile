inferno_docker_build:
	docker build -t inferno inferno
	docker build -t inferno_community inferno_community
	
git_update:
	git submodule update --init --remote --merge

inferno_docker_rebuild:
	docker build --no-cache -t inferno inferno
	docker build --no-cache -t inferno_community inferno_community
