rozwal_to - django app - reading data from rozwalto webpage. It is require to write username in admin panel <br />
Celery used as worker and beat <br />

docker build -f Django_Server -t django/score_app:01 . <br />
docker build -f Nginx -t nginx-reverse:01 . <br />

docker network create django_network <br />

./run.sh
