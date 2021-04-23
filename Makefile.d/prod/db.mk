prod_db_seed:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c ' \
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake seed:roles && \
		rake seed:admin'

prod_migrate_db:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate'
