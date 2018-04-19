git_update:
	git submodule update --remote --merge

crucible_docker_build:
	docker build -t crucible_smart_app crucible_smart_app
	
crucible_docker_rebuild:
	docker build --no-cache -t crucible_smart_app crucible_smart_app