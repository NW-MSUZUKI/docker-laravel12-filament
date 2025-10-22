install:
	@make clean
	@make build
	@make up
	docker compose exec app composer install
	docker compose exec app npm install
	docker compose exec app npm run build
	docker compose exec app cp .env.example .env
	docker compose exec app php artisan key:generate
	docker compose exec app php artisan storage:link
	docker compose exec app chmod -R 777 storage bootstrap/cache
	@make fresh
clean:
	docker compose down --rmi all --volumes --remove-orphans
build:
	docker compose build --no-cache --force-rm
up:
	docker compose up -d
down:
	docker compose down
ps:
	docker compose ps
fresh:
	docker compose exec web php artisan migrate:fresh --seed
web:
	docker compose exec web bash
sql:
	docker compose exec web bash -c 'psql -h postgres -p 5432 -d postgres -U default'
