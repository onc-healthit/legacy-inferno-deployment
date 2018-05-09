inferno_docker_build:
	docker build -t inferno inferno
	
git_update:
	git submodule update --init --remote --merge

inferno_docker_rebuild:
	docker build --no-cache -t inferno inferno