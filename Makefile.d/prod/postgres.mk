prod_postgres_export_dump_full:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c ' \
		pg_dump --format=c --dbname=$$DATABASE_URL_WITHOUT_QUERY > tmp/full.dump'

# prod_postgres_pg_basebackup:
# 	docker-compose \
# 		-p "$(PROJECT_NAME)_prod" \
# 		-f docker/prod.yml \
# 		run --rm postgres bash -c ' \
# 		pg_basebackup --dbname=$$DATABASE_URL_WITHOUT_QUERY -D /dumps'

# https://www.postgresql.org/docs/9.1/static/backup-file.html
# prod_postgres_filesystem:
# 	sudo tar -cf /var/backup_after_restore.tar /mnt/var/lib/docker/volumes/MYAPP_postgres_data_prod/_data

## https://www.postgresql.org/docs/9.1/static/backup-file.html
##
#prod_postgres_pg_resetxlog:
#	docker run \
#		-it --rm \
#		-v /mnt/var/lib/docker/volumes/MYAPP_postgres_data_prod/_data:/var/lib/postgresql/data \
#		postgres@sha256:8d6ae17feb31c198a40640f95a8e4e43df6b245bccaf1161216adbef5cdccf9a \
#		bash -c 'su - postgres -c "/usr/lib/postgresql/10/bin/pg_resetwal -D /var/lib/postgresql/data -f"'

prod_postgres_import_dump_full:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		export PGPASSWORD=$$DATABASE_PASSWORD && \
		createdb --echo --port=$$DATABASE_PORT --host=$$DATABASE_HOST --username=$$DATABASE_USER $$DATABASE_NAME && \
		(psql --dbname=$$DATABASE_URL_WITHOUT_QUERY < tmp/db_prod.sql)
		echo "Import done"'
