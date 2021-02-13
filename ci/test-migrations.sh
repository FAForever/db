#!/bin/bash
set -e

echo '# Start Migration Base Test...'
mysql --no-defaults -h "${MYSQL_HOST}" -u root -p"${MYSQL_ROOT_PASSWORD}" <<< "DROP DATABASE ${MYSQL_DATABASE};"
mysql --no-defaults -h "${MYSQL_HOST}" -u root -p"${MYSQL_ROOT_PASSWORD}" <<< "CREATE DATABASE ${MYSQL_DATABASE};"

echo 'Import dump ...'
mysql --no-defaults -h "${MYSQL_HOST}" -u root -p"${MYSQL_ROOT_PASSWORD}" "${MYSQL_DATABASE}" < ./faf-db-dump/dump.sql

echo 'Migrate ...'
flyway migrate

echo '... Migration Test finished.'
