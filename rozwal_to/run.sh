#!/bin/bash
docker rm -f db django nginx rabbit worker beat

DOCKER_NETWORK=django_network

DB_PASSWORD=postgres
DB_USER=postgres
DB_DB=michal_site
DB_NAME=db
DB_IMAGE=postgres:10

APP_IMAGE=django/score_app:01
APP_NAME=django
APP_RUN=app
CELERY_WORKER=worker
CELERY_WORKER_RUN=worker
CELERY_BEAT=beat
CELERY_BEAT_RUN=beat

NGINX_IMAGE=nginx-reverse:01
NGINX_NAME=nginx
NGINX_PORT=80

RABBIT_NAME=rabbit
RABBIT_IMAGE=rabbitmq:3.7-management
RABBIT_PORT=15672

docker run -d --name ${DB_NAME} \
-e POSTGRES_PASSWORD=${DB_PASSWORD} \
-e POSTGRES_USER=${DB_USER} \
-e POSTGRES_DB=${DB_DB} \
--network ${DOCKER_NETWORK} \
${DB_IMAGE}

docker run -d --network ${DOCKER_NETWORK} \
--name ${APP_NAME} \
-v /home/pawel/PycharmProjects/django_app/rozwal_to/static_files:/root/static \
${APP_IMAGE} ${APP_RUN}

docker run -d --network ${DOCKER_NETWORK} \
--name ${NGINX_NAME} \
-p ${NGINX_PORT}:80 \
-v /home/pawel/PycharmProjects/django_app/rozwal_to/static_files:/var/www/static \
${NGINX_IMAGE}

docker run -d --name ${RABBIT_NAME} \
-p ${RABBIT_PORT}:15672 \
--network ${DOCKER_NETWORK} \
${RABBIT_IMAGE}

docker run -d --network ${DOCKER_NETWORK} \
--name ${CELERY_WORKER} \
${APP_IMAGE} ${CELERY_WORKER_RUN}

docker run -d --network ${DOCKER_NETWORK} \
--name ${CELERY_BEAT} \
${APP_IMAGE} ${CELERY_BEAT_RUN}
