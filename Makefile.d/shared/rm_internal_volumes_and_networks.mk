rm_internal_volumes_and_networks_dev:
	docker-compose \
		-p "$(PROJECT_NAME)_dev" \
		-f docker/dev.yml \
		down --volumes --remove-orphans --rmi local

rm_internal_volumes_and_networks_tdd:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		down --volumes --remove-orphans --rmi local

rm_internal_volumes_and_networks_prod:
	docker-compose \
		-p "$(PROJECT_NAME)_prod" \
		-f docker/prod.yml \
		down --volumes --remove-orphans --rmi local

rm_internal_volumes_and_networks: rm_internal_volumes_and_networks_dev rm_internal_volumes_and_networks_tdd rm_internal_volumes_and_networks_prod
