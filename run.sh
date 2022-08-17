#!/bin/bash

cd /opt/docker

echo 'Excluir maquinas ... fase 1'
sudo docker ps -a | awk '{ print $14 }' | xargs sudo docker rm $0
echo 'Excluir maquinas ... fase 2'
sudo docker ps -a | awk '{ print $15 }' | xargs sudo docker rm $0

echo 'Monta os containers...'
sudo docker-compose up -d --build

#sudo docker build -t mywebapp .
#
#sudo docker run --rm -it -d -p 8888:8080 mywebapp


