migrate_db_dev:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate && \
		rake db:schema:dump'

migrate_db_local_production:
	docker-compose \
		-p "$(PROJECT_NAME)_local_production" \
		-f docker/local_production.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate && \
		rake db:seed && \
		rake db:schema:dump'

migrate_db_feature_tests:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests" \
		-f docker/feature_tests.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate && \
		rake db:schema:dump'

migrate_db_tdd:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		run --rm tests_runner bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate && \
		rake db:schema:dump'

migrate_db_unit_tests:
	docker-compose \
		-p "$(PROJECT_NAME)_unit_tests" \
		-f docker/unit_tests.yml \
		run --rm tests_runner bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate && \
		rake db:schema:dump'

migrate_db: migrate_db_dev migrate_db_feature_tests migrate_db_tdd migrate_db_unit_tests
