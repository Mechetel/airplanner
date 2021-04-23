drop_db_dev:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		sleep 2 && \
		( psql --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME --command=" \
				SELECT pg_terminate_backend(pg_stat_activity.pid) \
				FROM pg_stat_activity \
				WHERE pg_stat_activity.datname = current_database() \
  				AND pid <> pg_backend_pid();" || true ) && \
		( dropdb --echo --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME || true )'

drop_db_dev_with_prod_db:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		sleep 2 && \
		( psql --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME --command=" \
				SELECT pg_terminate_backend(pg_stat_activity.pid) \
				FROM pg_stat_activity \
				WHERE pg_stat_activity.datname = current_database() \
  				AND pid <> pg_backend_pid();" || true ) && \
		( dropdb --echo --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME || true )'

# XXX: will remove prod db
__drop_db_prod:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		( dropdb --echo --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME || true )'

__drop_db_prod_without_migrate:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		( dropdb --echo --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME || true )'

drop_db_tdd:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		run --rm tests_runner bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		sleep 2 && \
		( psql --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME --command=" \
				SELECT pg_terminate_backend(pg_stat_activity.pid) \
				FROM pg_stat_activity \
				WHERE pg_stat_activity.datname = current_database() \
  				AND pid <> pg_backend_pid();" || true ) && \
		( dropdb --echo --port=$$DATABASE_PORT \
		    --host=$$DATABASE_HOST --username=$$DATABASE_USER \
		    $$DATABASE_NAME || true )'

drop_db: drop_db_dev drop_db_dev_with_prod_db drop_db_tdd
