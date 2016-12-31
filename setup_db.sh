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
DB_CONTAINER=$(docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=banana -p 3306:3306 faf-db)

DB_ADDRESS=
if [[ $OSTYPE == darwin* ]]; then
  DB_ADDRESS="127.0.0.1"
else
  DB_ADDRESS=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${DB_CONTAINER})
fi

echo "Waiting for mysql container..."
until nc -z ${DB_ADDRESS} 3306
do
  sleep 1
done

echo "Creating database faf_test..."
until docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana -e "create database faf_test;"
do
  echo "Mysql still initializing, retrying in 10 seconds"
  sleep 10
done

echo "y
n
" | ./migrate.sh faf-db || exit 1;

if [ $DUMPSCHEMA ]; then
  docker exec -i ${DB_CONTAINER} mysqldump -uroot -pbanana --no-data faf_test || exit 1;
fi

docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana faf_test < db-data.sql || exit 1;
