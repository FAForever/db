#!/bin/bash

create() {
  database=$1
  username=$2
  password=$3

  mysql --user=root --password=${MYSQL_ROOT_PASSWORD} <<SQL_SCRIPT
    CREATE DATABASE IF NOT EXISTS \`${database}\`;
    CREATE USER '${username}'@'%' IDENTIFIED BY '${password}';
    GRANT ALL PRIVILEGES ON \`${database}\`.* TO '${username}'@'%';
SQL_SCRIPT
}

create "faf" "faf-java-api" "${MYSQL_JAVA_API_PASSWORD}"
create "faf" "faf-python-api" "${MYSQL_PYTHON_API_PASSWORD}"
create "faf" "faf-legacy-live-replay-server" "${MYSQL_LEGACY_LIVE_REPLAY_SERVER_PASSWORD}"
create "faf" "faf-legacy-secondary-server" "${MYSQL_LEGACY_SECONDARY_SERVER_PASSWORD}"
create "faf" "faf-legacy-updater" "${MYSQL_LEGACY_UPDATER_PASSWORD}"
create "faf-murmur" "faf-murmur" "${MYSQL_MURMUR_PASSWORD}"
create "faf" "faf-java-server" "${MYSQL_JAVA_SERVER_PASSWORD}"
create "faf" "faf-python-server" "${MYSQL_PYTHON_SERVER_PASSWORD}"
create "faf-softvote" "faf-softvote" "${MYSQL_SOFTVOTE_PASSWORD}"
create "faf-anope" "faf-anope" "${MYSQL_ANOPE_PASSWORD}"
create "faf-wiki" "faf-wiki" "${MYSQL_WIKI_PASSWORD}"
create "faf-wordpress" "faf-wordpress" "${MYSQL_WORDPRESS_PASSWORD}"
create "faf-phpbb3" "faf-phpbb3" "${MYSQL_PHPBB3_PASSWORD}"

# To update the IRC password, we give the python server full bloated access to all of anope's
# privates. FIXME: Have the API do this instead.
mysql --user=root --password=${MYSQL_ROOT_PASSWORD} <<SQL_SCRIPT
    GRANT ALL PRIVILEGES ON \`faf-anope\`.* TO 'faf-python-server'@'%';
    GRANT ALL PRIVILEGES ON \`faf-anope\`.* TO 'faf-java-server'@'%';
    GRANT ALL PRIVILEGES ON \`faf-anope\`.* TO 'faf-java-api'@'%';
SQL_SCRIPT

# Allows faf-mysql-exporter to read metrics. It is recommended to set a max connection limit for the user to avoid
# overloading the server with monitoring scrapes under heavy load.
mysql --user=root --password=${MYSQL_ROOT_PASSWORD} <<SQL_SCRIPT
  CREATE USER 'faf-mysql-exporter'@'%' IDENTIFIED BY '${MYSQL_MYSQL_EXPORTER_PASSWORD}' WITH MAX_USER_CONNECTIONS 3;
  GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'faf-mysql-exporter'@'%';
SQL_SCRIPT
