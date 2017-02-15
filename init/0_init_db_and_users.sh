#!/bin/bash

create() {
  database=$1
  username=$2
  password=$3

  mysql --user=root --password=${MYSQL_ROOT_PASSWORD} <<SQL_SCRIPT
    CREATE DATABASE IF NOT EXISTS \`${database}\`;
    CREATE USER '${username}'@'%' IDENTIFIED BY '${password}';
    GRANT ALL PRIVILEGES ON \`${database}\`.* TO '${username}'@'%';
    FLUSH PRIVILEGES;
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
