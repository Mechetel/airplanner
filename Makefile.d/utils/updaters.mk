#######
# NOTE:
# it doesn't matter which container to use here,
# because they all share MYAPP_be_gems external volume
bundle_install:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --no-deps be \
		bundle install --jobs 3

bundle_update:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --no-deps be \
		bundle update --jobs 3

yarn_install:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --no-deps be \
		yarn install

yarn_upgrade:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --no-deps be \
		yarn upgrade --latest

# https://github.com/maxcnunes/waitforit
update_wait_for_it:
	mkdir -p ./scripts && WAITFORIT_VERSION="v1.3.1" && wget --show-progress -q -O ./scripts/waitforit https://github.com/maxcnunes/waitforit/releases/download/$$WAITFORIT_VERSION/waitforit-linux_amd64 && chmod +x ./scripts/waitforit
