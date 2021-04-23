format-fix-js:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --no-deps be \
		yarn run format-fix

check-gem-security-issues:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --no-deps be \
		bundle audit
