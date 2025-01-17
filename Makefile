docker-exec = docker compose exec
app_exec = $(docker-exec) app

# Выполнять только один раз при загрузки всех проектов из гитлаба (git clone)
# !!! Перетерает все параметры
init: cp-env-force down-force docker-build up-back composer-install ps
# Выполнять Если комп перезагрузился или нужно рестартануть сервис
# Есть проблема с выполнением миграций (db-migration) сразу после старта контейнера, проблема в том что база накатывает дампы долго
start: cp-env down docker-pull up-back composer-install ps

#==================== Установка зависимостей - composer ======================
# Установка зависимостей
composer-install:
	$(app_exec) composer install
# Установка зависимостей
composer_update:
	$(app_exec) composer update

symfony_cache_clear:
	$(app_exec) composer app:cache-clear

#==================== Data Base / Mysql ======================
migration_diff:
	$(app_exec) composer doctrine:migrations:diff

migration_migrate:
	$(app_exec) composer doctrine:migrations:migrate

#==================== Docker CI/CD ======================
# Запускает приложение
up-back:
	docker compose up -d --wait-timeout 30 --wait --pull missing
	sleep 5

# Роняет поднятые контейнеры и удаляет все данные
down-force:
	docker compose down -v

down:
	docker compose down

# Посмотреть поднятые контейнеры
ps:
	docker compose ps -a

# перетерает конфигурацию
cp-env-force:
	cp docker-compose.override.dist.yml docker-compose.override.yml

# перестраховка если .env был удалён
cp-env:
	cp -n docker-compose.override.dist.yml docker-compose.override.yml

# https://dockerlabs.collabnix.com/intermediate/networking/Configuring_DNS.html
# sudo gedit /etc/docker/daemon.json
# { "dns": ["10.20.0.12 ", "8.8.8.8"]}
# sudo service docker restart
docker-build:
	docker compose build --pull --progress=plain

# Подтянуть актуальные образы из gitlab
docker-pull:
	docker compose pull

docker-push:
	docker compose push
