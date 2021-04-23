prod_up:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		up --force-recreate

prod_up_d:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		up -d --force-recreate
