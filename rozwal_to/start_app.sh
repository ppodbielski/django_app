#!/bin/bash

set -x

python3 ${HOME}/manage.py makemigrations
python3 ${HOME}/manage.py migrate --run-syncdb
python3 ${HOME}/manage.py collectstatic --clear --noinput
python3 ${HOME}/manage.py collectstatic --noinput
cd root
gunicorn --bind 0.0.0.0:8000 michal_site.wsgi

#python3 ${HOME}/manage.py runserver 0.0.0.0:8000
