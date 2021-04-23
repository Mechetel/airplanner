dev_run:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm --service-ports be

dev_seed:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm be bash -c ' \
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake seed:roles && \
		rake seed:admin && \
