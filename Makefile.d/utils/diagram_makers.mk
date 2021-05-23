##########
app_models_diagram:
	rm -f app_models_diagram.svg
	docker-compose \
		-p "$(PROJECT_NAME)_local_production" \
		-f docker/local_production.yml \
		run --rm be \
		bash -c 'export RAILS_LOG_TO_STDOUT=false && (railroady -M | dot -Tsvg > app_models_diagram.svg)'
