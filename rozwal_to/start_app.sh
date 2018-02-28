#!/bin/bash

set -x
USE=$1


if [[ "$USE" == "app" ]]; then
	while ! nc -w 1 --send-only ${DATABASE} ${DATABASE_PORT} < /dev/null; do sleep 3; done;
	python3 ${HOME}/manage.py makemigrations score
	python3 ${HOME}/manage.py migrate
	python3 ${HOME}/manage.py collectstatic
	cd root
	gunicorn --bind 0.0.0.0:8000 michal_site.wsgi
fi

if [[ $USE == "worker" ]]; then
	while ! nc -w 1 --send-only ${RABBIT} ${RABBIT_PORT} < /dev/null; do sleep 3; done;
	cd root
	celery -A michal_site.celery worker -Q rozwal_to --loglevel=info
fi

if [[ "$USE" == "beat" ]]; then
        while ! nc -w 1 --send-only ${RABBIT} ${RABBIT_PORT} < /dev/null; do sleep 3; done;
	cd root
	celery -A michal_site.celery beat --loglevel=info
fi

