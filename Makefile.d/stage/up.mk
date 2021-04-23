stage_up:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		up --force-recreate
