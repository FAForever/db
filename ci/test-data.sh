#!/bin/bash
set -e

echo '# Import test data'

echo "Insert test-data.sql for 1st run"
mysql -h "${MYSQL_HOST}" -u root -p"${MYSQL_ROOT_PASSWORD}" "${MYSQL_DATABASE}" < test-data.sql || { echo "Test data failed"; exit 1; };

echo "Insert test-data.sql for 2nd run (ensure cleanup works as well)"
mysql -h "${MYSQL_HOST}" -u root -p"${MYSQL_ROOT_PASSWORD}" "${MYSQL_DATABASE}" < test-data.sql || { echo "Test data failed"; exit 1; };
