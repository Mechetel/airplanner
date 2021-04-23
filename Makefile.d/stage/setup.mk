stage_install_deps:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		run --rm be bash -c '\
		bundle install && \
		yarn install'

stage_compile_assets:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		run --rm be bash -c '\
		rake assets:clean && \
		rake assets:precompile'

stage_setup: stage_install_deps stage_compile_assets
