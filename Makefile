.DEFAULT_GOAL := usage

build:
	docker-compose build

bundle:
	docker-compose run --rm app bundle config --delete without test
	docker-compose run --rm app bundle config --delete without development
	docker-compose run --rm app bundle install
	docker-compose run --rm sidekiq bundle install

up:
	rm -f tmp/pids/server.pid
	docker-compose up

up.detach:
	rm -f tmp/pids/server.pid
	docker-compose up -d

down:
	docker-compose down

stop:
	docker-compose stop

db.migrate:
	docker-compose run --rm app bundle exec rails db:create db:migrate
	docker-compose run --rm back bundle exec rails annotate_models

db.login:
	docker-compose exec db psql -U user -d app_development

rails.console:
	docker-compose run --rm back bundle exec rails c

rspec: bundle db.migrate
	docker-compose run --rm -e RAILS_ENV=test app bundle exec rails db:drop db:create db:migrate