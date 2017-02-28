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

create "faf" "faf-api" "${MYSQL_API_PASSWORD}"
create "faf" "faf-legacy-apps" "${MYSQL_LEGACY_APPS_PASSWORD}"
create "faf" "faf-legacy-live-replay-server" "${MYSQL_LEGACY_LIVE_REPLAY_SERVER_PASSWORD}"
create "faf" "faf-legacy-secondary-server" "${MYSQL_LEGACY_SECONDARY_SERVER_PASSWORD}"
create "faf" "faf-legacy-updater" "${MYSQL_LEGACY_UPDATER_PASSWORD}"
create "faf-murmur" "faf-murmur" "${MYSQL_MURMUR_PASSWORD}"
create "faf" "faf-server" "${MYSQL_SERVER_PASSWORD}"
create "faf-softvote" "faf-softvote" "${MYSQL_SOFTVOTE_PASSWORD}"
create "faf-anope" "faf-anope" "${MYSQL_ANOPE_PASSWORD}"
create "faf-wiki" "faf-wiki" "${MYSQL_WIKI_PASSWORD}"
create "faf-wordpress" "faf-wordpress" "${MYSQL_WORDPRESS_PASSWORD}"

# faf-server needs to be able to update passwords in Anope's database. While we should only give write permission to
# that specific table, this would require this project to know about the prefix and table names used by Anope, which I
# consider worse than giving faf-server more permissions than it needs.
mysql --user=root --password=${MYSQL_ROOT_PASSWORD} <<SQL_SCRIPT
    GRANT ALL PRIVILEGES ON \`faf-anope\`.* TO 'faf-server'@'%';
SQL_SCRIPT
