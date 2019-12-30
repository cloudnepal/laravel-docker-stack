dir=${CURDIR}
project="-p $(shell basename $(CURDIR))"
service=laravel:latest

up:
	@docker-compose -f docker-compose.yml $(project) up -d --remove-orphans

down:
	@docker-compose -f docker-compose.yml $(project) down

restart: down up

env:
	@make exec cmd="cp ./.env.example ./.env"

ssh:
	@docker-compose $(project) exec laravel bash

keygen:
	@docker-compose $(project) exec laravel bash -c "php artisan key:gen"

ssh-supervisord:
	@docker-compose $(project) exec supervisord bash

ssh-mysql:
	@docker-compose $(project) exec mysql bash

exec:
	@docker-compose $(project) exec laravel $$cmd

auth:
	@make exec cmd="php artisan make:auth"

composer-install-prod:
	@make exec cmd="composer install --no-dev"

composer-install:
	@make exec cmd="composer install"

composer-update:
	@make exec cmd="composer update"

info:
	@make exec cmd="php artisan --version"
	@make exec cmd="php --version"

logs:
	@docker logs -f laravel

logs-supervisord:
	@docker logs -f supervisord

logs-mysql:
	@docker logs -f mysql

fresh-migrate-seed:
	@make exec cmd="php artisan migrate:fresh --seed"

drop-migrate:
	@make exec cmd="php artisan migrate:fresh"
	@make exec cmd="php artisan migrate:fresh --env=test"

migrate-prod:
	@make exec cmd="php artisan migrate --force"

migrate:
	@make exec cmd="php artisan migrate --force"
	@make exec cmd="php artisan migrate --force --env=test"

seed:
	@make exec cmd="php artisan db:seed --force"