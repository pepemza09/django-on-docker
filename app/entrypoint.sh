#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# si queremos que no se vacien los datos de la db y que se hagan las migraciones hay que descomentar las siguientes líneas
# python manage.py flush --no-input
# python manage.py migrate

# manualmente se puede hacer así
# $ docker-compose exec web python manage.py flush --no-input
# $ docker-compose exec web python manage.py migrate

python manage.py flush --no-input
python manage.py migrate

exec "$@"