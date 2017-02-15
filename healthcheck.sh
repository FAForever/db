#!/bin/sh

echo "SELECT 1;" | mysql --host="127.0.0.1" --user="root" --password="${MYSQL_ROOT_PASSWORD}" > /dev/null

exit $?
