#!/usr/bin/env bash

DUMPSCHEMA=

while getopts ":d" opt; do
  case $opt in
    d)
      DUMPSCHEMA=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Builds and runs the faf-db image in a new container and waits until it initialized

docker build -t faf-db .

echo "Waiting for mysql container..."
DB_CONTAINER=$(docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=banana -p 3306:3306 faf-db)
until nc -z $(docker inspect --format='{{.NetworkSettings.IPAddress}}' ${DB_CONTAINER}) 3306
do
  sleep 1
done

echo "Creating database faf_test"
docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana -e "create database faf_test;" || exit 1;

echo "y
n
" | ./migrate.sh faf-db || exit 1;

if [ $DUMPSCHEMA ]; then
  docker exec -i ${DB_CONTAINER} mysqldump -uroot -pbanana --no-data faf_test || exit 1;
fi

docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana faf_test < db-data.sql || exit 1;
