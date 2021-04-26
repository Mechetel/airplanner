dev_with_prod_db_up:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		up

dev_with_prod_db_run:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm --service-ports be

dev_with_prod_db_seed:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm be bash -c ' \
		waitforit -host=postgres -port=5432 -timeout=30 && \
		rake seed:roles && \
		rake seed:admin'

dev_with_prod_db_redis_inspect:
	redis-commander --redis-port 6379 --redis-host $$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' devwithproddb_redis_1)

# docker-compose \
# 	-p "$(PROJECT_NAME)_dev" \
# 	-f docker/dev.yml \
# 	run --rm --no-deps be bash -c '\
# 	waitforit -host=postgres -port=5432 -timeout=30 && \
# 	export PGPASSWORD=$$DATABASE_PASSWORD && \
# 	createdb --echo --port=$$POSTGRES_PORT --host=$$POSTGRES_HOST --username=$$DATABASE_USER $$POSTGRES_DB && \
# 	pg_restore --format=c --dbname=postgres://$$DATABASE_USER:$$DATABASE_PASSWORD@$$POSTGRES_HOST:$$POSTGRES_PORT/$$POSTGRES_DB tmp/dump.sql.gz && \
# 	echo "Import done"'

dev_with_prod_db_postgres_import_dump_full:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		sleep 5 && \
		createdb --echo --port=$$DATABASE_PORT --host=$$DATABASE_HOST --username=$$DATABASE_USER $$DATABASE_NAME && \
		pg_restore --no-owner --no-privileges --format=c --dbname=$$DATABASE_URL_WITHOUT_QUERY tmp/full.dump && \
		echo "Import done"'

dev_with_prod_db_postgres_import_dump_sql:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		sleep 5 && \
		createdb --echo --port=$$DATABASE_PORT --host=$$DATABASE_HOST --username=$$DATABASE_USER $$DATABASE_NAME && \
		(psql --dbname=$$DATABASE_URL_WITHOUT_QUERY < tmp/db_prod.sql) && \
		echo "Import done"'

dev_with_prod_db_postgres_export_dump_full:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm --service-ports be bash -c ' \
		pg_dump --format=c --dbname=$$DATABASE_URL_WITHOUT_QUERY > tmp/full.dump'

# dev_with_prod_db_postgres_export_dump_all:
# 	docker-compose \
# 		-p "$(PROJECT_NAME)_dev_with_prod_db" \
# 		-f docker/dev_with_prod_db.yml \
# 		run --rm --service-ports be bash -c ' \
# 		pg_dumpall --dbname=$$DATABASE_URL > tmp/all.dump'

dev_with_prod_db_elasticsearch_recreate:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm sidekiq bash -c ' \
		waitforit -host=elasticsearch -port=9200 -timeout=30 && \
		rake elasticsearch:prune && \
		rake elasticsearch:migrate_v1 && \
		rake elasticsearch:update_index'

dev_with_prod_db_test_procompile:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm --no-deps be bash -c ' \
		export RAILS_ENV=production && \
		rake assets:clean && \
		rake assets:precompile'
