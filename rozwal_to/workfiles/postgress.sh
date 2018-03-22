#!/bin/bash
DB_PASSWORD=postgres
DB_USER=postgres
DB_DB=michal_site
DB_NAME=db
DB_IMAGE=postgres:10
DOCKER_NETWORK=django_network
docker run -d --name ${DB_NAME} \
-e POSTGRES_PASSWORD=${DB_PASSWORD} \
-e POSTGRES_USER=${DB_USER} \
-e POSTGRES_DB=${DB_DB} \
--network ${DOCKER_NETWORK} \
-p 5432:5432 \
${DB_IMAGE}

