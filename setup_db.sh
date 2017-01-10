#!/usr/bin/env bash

DUMP_SCHEMA_TO_CONTAINER_STDOUT=
COPY_SCHEMA_TO_HOST_FILE=

while getopts ":dc" opt; do
  case $opt in
    d)
      DUMP_SCHEMA_TO_CONTAINER_STDOUT=1
      ;;
    c)
      COPY_SCHEMA_TO_HOST_FILE=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1;
      ;;
  esac
done

# Check if docker is running
docker version 1>/dev/null || exit 1;

# Builds image
docker build -t faf-db .
DB_CONTAINER=$(docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=banana -p 3306:3306 faf-db) || exit 1;

# Run faf-db image in a new container and waits until it initialized
echo "Creating database faf_test..."
until docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana -e "create database faf_test;" 2>/dev/null;
do
  echo "Mysql still initializing, retrying in 10 seconds";
  sleep 10;
done
echo "Successfully created database faf_test";

echo "y
n
" | ./migrate.sh faf-db || exit 1;

if [ $DUMP_SCHEMA_TO_CONTAINER_STDOUT ]; then
  docker exec -i ${DB_CONTAINER} mysqldump -uroot -pbanana --no-data faf_test || exit 1;
fi

if [ $COPY_SCHEMA_TO_HOST_FILE ]; then
  docker exec -i ${DB_CONTAINER} /bin/sh -c "mysqldump -uroot -pbanana --no-data faf_test > /tmp/dump.sql" || exit 1;
  docker cp ${DB_CONTAINER}:/tmp/dump.sql /tmp/dump.sql || exit 1;
  docker exec -i ${DB_CONTAINER} rm -f /tmp/dump.sql || exit 1;
  echo "Schema copied to /tmp/dump.sql"
fi

docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana faf_test < db-data.sql || exit 1;
