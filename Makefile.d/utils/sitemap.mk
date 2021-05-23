# XXX: local_production
sitemap_refresh_without_ping:
	docker-compose \
		-p "$(PROJECT_NAME)_local_production" \
		-f docker/local_production.yml \
		run --rm be rake sitemap:refresh:no_ping

sitemap_install:
	docker-compose \
		-p "$(PROJECT_NAME)_local_production" \
		-f docker/local_production.yml \
		run --rm be rake sitemap:install

# XXX: prod
# do this only on prod server
sitemap_refresh_and_ping:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be rake sitemap:refresh
