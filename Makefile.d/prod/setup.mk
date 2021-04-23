prod_install_deps:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		bundle install && \
		yarn install'

prod_compile_assets:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		run --rm be bash -c '\
		rake assets:clean && \
		rake assets:precompile'

prod_setup: prod_install_deps prod_compile_assets
