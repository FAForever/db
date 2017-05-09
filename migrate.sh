#!/usr/bin/env bash

if [ ! "${MYSQL_ROOT_PASSWORD+1}" ]; then
  echo "This script is not intended for use outside the docker container (variable MYSQL_ROOT_PASSWORD has not been set)"
  echo "Try instead: docker exec -i faf-db ${0}"
  exit 1
fi

cat <<EOF > /flyway/conf/flyway.conf
flyway.url=jdbc:mysql://127.0.0.1/faf?localSocket=/var/run/mysqld/mysqld.sock
flyway.user=root
flyway.password=${MYSQL_ROOT_PASSWORD}
EOF

./flyway/flyway migrate
