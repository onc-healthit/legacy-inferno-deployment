crucible_docker_build:
	docker build -t crucible_smart_app crucible_smart_app
	
git_update:
	git submodule update --remote --merge

git_submodule_init:
	git submodule --init

crucible_docker_rebuild:
	docker build --no-cache -t crucible_smart_app crucible_smart_app