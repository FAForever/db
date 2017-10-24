#!/bin/bash

# This script is necessary because the mysql entrypoint script won't let use
# run anything as root.

# Put mysql root pw into /root/.my.cnf
# This allows docker exec -it faf-db mysql to work without having to pass or enter password
#mysql_config_editor set --login-path=faf_lobby --host=localhost --user=root --password
cat > /root/.my.cnf <<LOGIN_CNF
[client]
user = root
password = ${MYSQL_ROOT_PASSWORD}
host = localhost
LOGIN_CNF

# Now run the real script
docker-entrypoint.sh $@
