#!/bin/bash

set -x
USE=$1

if [[ "$USE" == "app" ]]; then
	while ! nc -w 1 --send-only ${DB_HOST} ${DB_PORT} < /dev/null; do sleep 3; done;
	python manage.py migrate
	python manage.py collectstatic --noinput
	/bin/bash
	gunicorn --bind 0.0.0.0:8000 michal_site.wsgi

elif [[ $USE == "worker" ]]; then
	while ! nc -w 1 --send-only ${RABBIT_HOST} ${RABBIT_PORT} < /dev/null; do sleep 3; done;
	celery -A michal_site.celery worker -Q rozwal_to --loglevel=info

elif [[ "$USE" == "beat" ]]; then
        while ! nc -w 1 --send-only ${RABBIT_HOST} ${RABBIT_PORT} < /dev/null; do sleep 3; done;
	celery -A michal_site.celery beat --loglevel=info

else 
    exec "$@"
fi    

