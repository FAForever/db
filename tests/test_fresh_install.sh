#!/usr/bin/env bash

# Creates a fresh database and loads db-structure.sql and db-data.sql
# To be executed in the project root

db=faf_test
pw=banana
docker_container=faf-db

echo "drop database if exists ${db}; create database ${db}" | docker exec -i ${docker_container} mysql -p${pw} \
&& cat db-structure.sql | docker exec -i ${docker_container} mysql -p${pw} ${db} \
&& cat db-data.sql | docker exec -i ${docker_container} mysql -p${pw} ${db}

exit $?