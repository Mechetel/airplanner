stage_db_seed:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		run --rm be bash -c ' \
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake seed:roles && \
		rake seed:admin'

stage_migrate_db:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake db:migrate'

stage_postgres_import_dump_full:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		createdb --echo --port=$$DATABASE_PORT --host=$$DATABASE_HOST --username=$$DATABASE_USER $$DATABASE_NAME && \
		pg_restore --format=c --dbname=$$DATABASE_URL_WITHOUT_QUERY tmp/full.dump && \
		echo "Import done"'

stage_postgres_import_dump_full_from_sql:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		createdb --echo --port=$$DATABASE_PORT --host=$$DATABASE_HOST --username=$$DATABASE_USER $$DATABASE_NAME && \
		psql --dbname=$$DATABASE_URL_WITHOUT_QUERY -f tmp/db_prod.sql && \
		echo "Import done"'
