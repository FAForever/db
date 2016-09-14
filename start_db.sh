#!/usr/bin/env bash

# Builds and runs the faf-db image in a new container and wait until it initialized

docker build -t faf-db .

echo "Waiting for mysql container..."
DB_CONTAINER=`docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=banana faf-db`
until nc -z $(sudo docker inspect --format='{{.NetworkSettings.IPAddress}}' $DB_CONTAINER) 3306
do
  sleep 1
done