# how to TDD:
# - run be:            make tdd_be
# - run guard:         make tdd_guard
# - connect to chrome: vncviewer 0.0.0.0:5900

tdd_be:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		run --service-ports --rm --name MYAPP_feature_tests_be be

tdd_guard:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		run --rm tests_runner

tdd_run_only_mails:
	docker-compose \
		-p "$(PROJECT_NAME)_tdd" \
		-f docker/tdd.yml \
		run --rm tests_runner \
		bash -c " \
		waitforit -host=postgres -port=5432 -timeout=30 && \
		waitforit -host=hub -port=4444 -timeout=15 && \
		bundle exec rspec --order rand --require /app/spec/entries/feature/spec_helper.rb /app/spec/entries/unit/mailers"
