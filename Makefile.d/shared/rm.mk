rm_dev:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		rm -f -s -v

rm_tdd:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		rm -f -s -v

rm_prod:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		rm -f -s -v

rm_stage:
	docker-compose \
		-p "$(PROJECT_NAME)_stage" \
		-f docker/stage.yml \
		rm -f -s -v

rm: rm_dev rm_tdd rm_prod rm_stage
