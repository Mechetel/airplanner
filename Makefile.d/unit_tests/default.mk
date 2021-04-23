unit_tests_recreate_db:
	docker-compose \
		-p "$(PROJECT_NAME)_unit_tests" \
		-f docker/unit_tests.yml \
		run --rm tests_runner bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create && \
		rake db:migrate && \
		rake db:schema:dump'

unit_tests_run:
	docker-compose \
		-f docker/unit_tests.yml \
		-p "$(PROJECT_NAME)_unit_tests" \
		run --rm tests_runner

unit_tests_run_models_only:
	docker-compose \
		-p "$(PROJECT_NAME)_unit_tests" \
		-f docker/unit_tests.yml \
		run --rm tests_runner \
		bundle exec rspec --order rand --require /app/spec/entries/unit/spec_helper.rb /app/spec/entries/unit/models

unit_tests_rm:
	docker-compose \
		-p "$(PROJECT_NAME)_unit_tests" \
		-f docker/unit_tests.yml \
		rm -f -s -v
	docker-compose \
		-p "$(PROJECT_NAME)_unit_tests" \
		-f docker/unit_tests.yml \
		down --volumes --remove-orphans --rmi local
