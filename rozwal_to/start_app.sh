#!/bin/bash

set -x

python3 ${HOME}/manage.py makemigrations
python3 ${HOME}/manage.py migrate
python3 ${HOME}/manage.py runserver 0.0.0.0:8000
