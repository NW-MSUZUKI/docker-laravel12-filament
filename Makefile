install:
	@make clean
	@make build
	@make up
	docker compose exec filament-web composer install
	docker compose exec filament-web npm install
	docker compose exec filament-web npm run build
	docker compose exec filament-web cp .env.example .env
	docker compose exec filament-web php artisan key:generate
	docker compose exec filament-web php artisan storage:link
	docker compose exec filament-web chmod -R 777 storage bootstrap/cache
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
	docker compose exec filament-web php artisan migrate:fresh --seed
web:
	docker compose exec filament-web bash
sql:
	docker compose exec filament-web bash -c 'psql -h filament-db -p 5432 -d devdb -U default'
