recreate_db_dev:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create && \
		rake db:migrate && \
		rake db:schema:dump'

# XXX: will remove prod db
__recreate_db_prod:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create && \
		rake db:migrate && \
		rake db:schema:dump'

__recreate_db_prod_without_migrate:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create'

recreate_db_tdd:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		run --rm tests_runner bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create && \
		rake db:migrate && \
		rake db:schema:dump'

recreate_db: recreate_db_dev recreate_db_tdd
