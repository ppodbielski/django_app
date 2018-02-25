#!/bin/bash
docker rm -f db django nginx rabbit worker beat

docker run -d --name db \
--hostname db \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=michal_site \
--network django_network \
postgres:10

sleep 5

docker run -d --network django_network \
--name django \
-v /home/pawel/PycharmProjects/django_app/rozwal_to/static_files:/root/static \
django/score_app:01 app


docker run -d --network django_network \
--name nginx \
-p 80:80 \
-v /home/pawel/PycharmProjects/django_app/rozwal_to/static_files:/var/www/static \
nginx-reverse:01

docker run -d --name rabbit \
-p 15672:15672 \
--network django_network \
rabbitmq:3.7-management

docker run -d --network django_network \
--name worker \
django/score_app:01 beat

docker run -d --network django_network \
--name beat \
django/score_app:01 worker
