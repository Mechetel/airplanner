# XXX: dev_with_prod_db
sitemap_refresh_without_ping:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm be rake sitemap:refresh:no_ping

sitemap_install:
	docker-compose \
		-p "$(PROJECT_NAME)_dev_with_prod_db" \
		-f docker/dev_with_prod_db.yml \
		run --rm be rake sitemap:install

# XXX: prod
# do this only on prod server
sitemap_refresh_and_ping:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be rake sitemap:refresh
