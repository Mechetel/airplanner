# HOW TO USE LOCALLY (from https://gitlab.MYCOMPANY.com/srghma/MYAPP/container_registry)
# First log in to GitLab’s Container Registry using your GitLab username and password. If you have 2FA enabled you need to use a personal access token:
# docker login registry.MYCOMPANY.com

DOCKER_IMAGE_MAINTAINER_NAME := srghma
DOCKER_BUILD_EMPTY_CONTEXT := "docker/Dockerfiles"

# --- be --------------------------------------------------------------------

build_be:
	docker build \
		--cache-from "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be:latest" \
		--tag "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be:latest" \
		-f docker/Dockerfiles/be.Dockerfile $(DOCKER_BUILD_EMPTY_CONTEXT)

push_be:
	docker push "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be:latest"

pull_be:
	(docker pull "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be:latest" || true)

pull_build_push_be:
	$(MAKE) pull_be
	$(MAKE) build_be
	$(MAKE) push_be

# --- be_with_deps --------------------------------------------------------------------

build_be_with_deps:
	docker build \
		--cache-from "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be_with_deps:latest" \
		--tag "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be_with_deps:latest" \
		-f docker/Dockerfiles/be_with_deps.Dockerfile .

push_be_with_deps:
	docker push "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be_with_deps:latest"

pull_be_with_deps:
	(docker pull "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/be_with_deps:latest" || true)

pull_build_push_be_with_deps:
	$(MAKE) pull_be_with_deps
	$(MAKE) build_be_with_deps
	$(MAKE) push_be_with_deps

# --- filemanager --------------------------------------------------------------------

build_filemanager:
	docker build \
		--cache-from "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/filemanager:latest" \
		--tag "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/filemanager:latest" \
		-f docker/Dockerfiles/filemanager.Dockerfile docker/datum/filemanager

push_filemanager:
	docker push "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/filemanager:latest"

pull_filemanager:
	(docker pull "registry.MYCOMPANY.com/$(DOCKER_IMAGE_MAINTAINER_NAME)/$(PROJECT_NAME)/filemanager:latest" || true)

pull_build_push_filemanager:
	$(MAKE) pull_filemanager
	$(MAKE) build_filemanager
	$(MAKE) push_filemanager

# --- all --------------------------------------------------------------------

build_all: \
	build_be_with_deps

pull_build_push_all: \
	pull_build_push_be_with_deps

pull_all: \
	pull_be_with_deps
