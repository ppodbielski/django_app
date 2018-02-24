#!/bin/bash

set -x

python3 ${HOME}/manage.py makemigrations score
python3 ${HOME}/manage.py migrate
python3 ${HOME}/manage.py collectstatic
#python3 ${HOME}/manage.py collectstatic --noinput
cd root
gunicorn --bind 0.0.0.0:8000 michal_site.wsgi

#python3 ${HOME}/manage.py runserver 0.0.0.0:8000
