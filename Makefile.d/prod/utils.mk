prod_rake_stripe_sync:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		rake stripe:sync'
