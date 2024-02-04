# Создание дампа 

Прокинуть внутрь контейнера директорию 
`./mailing-management-db/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d`

Войти в контейнер `docker compose exec db bash `

Сделать бекап схем 

```shell

mysqldump -uroot -hlocalhost -proot app > /docker-entrypoint-initdb.d/app.sql
```

возможно потребуется вставить
```sql
-- /docker-entrypoint-initdb.d/app.sql
create schema app;
use app;
```

Для хранения в гитлабе желательно архивировать gzip. Ещё нужно указать приоритет выполнения
```shell
cd ./mailing-management-db/docker-entrypoint-initdb.d
gzip app.sql 
# Будет app.sql.gz
```