feature_tests_admin_recreate_db:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_admin" \
		-f docker/feature_tests.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create && \
		rake db:migrate && \
		rake db:schema:dump'

feature_tests_admin_run:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_admin" \
		-f docker/feature_tests.yml \
		run --rm tests_runner bash -c "\
		waitforit -host=postgres -port=5432 -timeout=200 && \
		waitforit -host=chrome -port=24444 -timeout=15 && \
		waitforit -host=be -port=3000 -timeout=30 && \
		waitforit -host=elasticsearch -port=9200 -timeout=200 && \
		(curl --silent --fail --connect-timeout 40 http://be:3000 > /dev/null) && \
		(bundle exec rspec --order rand --require /app/spec/entries/feature/spec_helper.rb /app/spec/entries/feature/admin || bundle exec rspec --only-failures --require /app/spec/entries/feature/spec_helper.rb)"

feature_tests_admin_rm:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_admin" \
		-f docker/feature_tests.yml \
		rm -f -s -v
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_admin" \
		-f docker/feature_tests.yml \
		down --volumes --remove-orphans --rmi local

feature_tests_frontend_recreate_db:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_frontend" \
		-f docker/feature_tests.yml \
		run --rm be bash -c '\
		waitforit -host=postgres -port=5432 -timeout=30 && \
		(rake db:drop || true) && \
		rake db:create && \
		rake db:migrate && \
		rake db:schema:dump'

feature_tests_frontend_run_1:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_frontend" \
		-f docker/feature_tests.yml \
		run --rm tests_runner bash -c "\
		waitforit -host=postgres -port=5432 -timeout=200 && \
		waitforit -host=chrome -port=24444 -timeout=15 && \
		waitforit -host=be -port=3000 -timeout=30 && \
		waitforit -host=elasticsearch -port=9200 -timeout=200 && \
		(curl --silent --fail --connect-timeout 40 http://be:3000 > /dev/null) && \
		(bundle exec rspec --order rand --require /app/spec/entries/feature/spec_helper.rb /app/spec/entries/feature/frontend_1 || bundle exec rspec --only-failures --require /app/spec/entries/feature/spec_helper.rb)"

feature_tests_frontend_run_2:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_frontend" \
		-f docker/feature_tests.yml \
		run --rm tests_runner bash -c "\
		waitforit -host=postgres -port=5432 -timeout=200 && \
		waitforit -host=chrome -port=24444 -timeout=15 && \
		waitforit -host=be -port=3000 -timeout=30 && \
		waitforit -host=elasticsearch -port=9200 -timeout=200 && \
		(curl --silent --fail --connect-timeout 40 http://be:3000 > /dev/null) && \
		(bundle exec rspec --order rand --require /app/spec/entries/feature/spec_helper.rb /app/spec/entries/feature/frontend_2 || bundle exec rspec --only-failures --require /app/spec/entries/feature/spec_helper.rb)"

feature_tests_frontend_rm:
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_frontend" \
		-f docker/feature_tests.yml \
		rm -f -s -v
	docker-compose \
		-p "$(PROJECT_NAME)_feature_tests_frontend" \
		-f docker/feature_tests.yml \
		down --volumes --remove-orphans --rmi local
