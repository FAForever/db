#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <test_rev>"
  echo "    <test_rev>  The DB revision to restore"
  echo
  echo "Example: $0 \$(git rev-parse HEAD)"
  exit 1
fi

db=faf_test
pw=banana
previousRev=$1
docker_container=faf-db

docker exec -i ${docker_container} mysql -p${pw} -e "drop database if exists ${db}; create database ${db}" \
&& git cat-file -p ${previousRev}:db-structure.sql | docker exec -i ${docker_container} mysql -p${pw} ${db} \
&& git cat-file -p ${previousRev}:db-data.sql | docker exec -i ${docker_container} mysql -p${pw} ${db}

exit $?