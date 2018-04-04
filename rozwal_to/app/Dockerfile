FROM centos:centos7

# Install essential

ARG DB_PASSWORD='postgres'
ARG DB_USER='postgres'
ARG DB_NAME='michal_site'
ARG DB_HOST='db'
ARG DB_PORT='5432'

ARG RABBIT_NAME='guest'
ARG RABBIT_PASSWORD='guest'
ARG RABBIT_PORT='5672'
ARG RABBIT_HOST='rabbit'

ENV DB_PASSWORD=${DB_PASSWORD} \
    DB_USER=${DB_USER} \
    DB_NAME=${DB_NAME} \
    DB_HOST=${DB_HOST} \
    DB_PORT=${DB_PORT} \
    RABBIT_NAME=${RABBIT_NAME} \
    RABBIT_PASSWORD=${RABBIT_PASSWORD} \
    RABBIT_PORT=${RABBIT_PORT} \
    RABBIT_HOST=${RABBIT_HOST}

RUN yum -y update ;\
    yum clean all ;\
    yum -y install epel-release ;\
    yum clean all ;\ 
    yum -y install python36 \
    python34-setuptools \
    nc \
    yum clean all 
RUN easy_install-3.4 pip

ADD root /root
RUN pip3 install -r root/requirements.txt
RUN ln -fs /usr/bin/python3 /usr/bin/python

EXPOSE 8000
WORKDIR /root

ENTRYPOINT ["./start_app.sh"]
