#!/bin/bash
docker rm -f db django

docker run -d --name db \
--hostname db \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=michal_site \
--network django_network \
postgres:latest

sleep 5

docker run -d --network django_network \
--name django \
-p 8000:8000 \
django/score_app:01
