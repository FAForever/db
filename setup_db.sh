#!/usr/bin/env bash

DUMP_SCHEMA=
HOST_LOCATION=
spin='-\|/'
spin_index=0

rotate_loading_spinner() {
    spin_index=$(( (spin_index+1) % 4 ))
    printf "\r${spin:$spin_index:1}"
}

show_help() {
    printf "Usage: ./setup_db.sh [options]
       ./setup_db.sh -c /tmp/dump.sql
       ./setup_db.sh -c /tmp

Options:
    -d                   Dump db schema to container stdout
    -c \033[4mfile\033[0m              Dump db schema to provided host location, if directory provided, file name will be dump.sql
    -h                   Print script command line options.\n"
    exit 1;
}

while getopts ":dc:h" opt; do
  case $opt in
    d)
      DUMP_SCHEMA=1
      ;;
    c)
      HOST_LOCATION=$OPTARG
      ;;
    h)
      show_help
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
  rotate_loading_spinner
  sleep 1;
done
printf "\nSuccessfully created database faf_test";

echo "y
n
" | ./migrate.sh faf-db || exit 1;

if [ $DUMP_SCHEMA ]; then
  docker exec -i ${DB_CONTAINER} mysqldump -uroot -pbanana --no-data faf_test || exit 1;
fi

if [ $HOST_LOCATION ]; then
  docker exec -i ${DB_CONTAINER} /bin/sh -c "mysqldump -uroot -pbanana --no-data faf_test > /tmp/dump.sql" || exit 1;
  docker cp ${DB_CONTAINER}:/tmp/dump.sql ${HOST_LOCATION} || exit 1;
  docker exec -i ${DB_CONTAINER} rm -f /tmp/dump.sql || exit 1;
  echo "Schema copied to ${HOST_LOCATION}"
fi

docker exec -i ${DB_CONTAINER} mysql -uroot -pbanana faf_test < db-data.sql || exit 1;
