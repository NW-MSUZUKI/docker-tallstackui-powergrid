install:
	@make clean
	@make build
	@make up
	docker compose exec dev-tallstackui-web composer install
	docker compose exec dev-tallstackui-web npm install
	docker compose exec dev-tallstackui-web npm run build
	docker compose exec dev-tallstackui-web cp .env.example .env
	docker compose exec dev-tallstackui-web php artisan key:generate
	docker compose exec dev-tallstackui-web php artisan storage:link
	docker compose exec dev-tallstackui-web chmod -R 777 storage bootstrap/cache
	@make fresh
clean:
	docker compose down --rmi all --volumes --remove-orphans
build:
	docker compose build --no-cache --force-rm
up:
	docker compose up -d
Up:
    docker-compose up -d dev-tallstackui-php-cli dev-tallstackui-web
down:
	docker compose down
ps:
	docker compose ps
fresh:
	docker compose exec dev-tallstackui-web php artisan migrate:fresh --seed
web:
	docker compose exec dev-tallstackui-web bash
sql:
	docker compose exec dev-tallstackui-web bash -c 'psql -h dev-tallstackui-db -p 5432 -d devdb -U wsat'
