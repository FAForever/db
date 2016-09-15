#!/bin/bash

# This script helps running database migration.

if [ -z "$1" ]; then
    read -p "Name or ID of docker container: " docker_container
else
    docker_container=$1
    shift
fi

docker_exec="docker exec -i ${docker_container}"

if [ ! -f flyway.conf ]; then
    read -r -p "No Flyway configuration found (flyway.conf). Should I use the example file? [y/N] " copy_example

    if [[ ${copy_example} =~ ^[Yy]$ ]]; then
        cp example_flyway.conf flyway.conf
    else
        echo "Then please create one first."
        exit 1
    fi
fi


docker exec -i ${docker_container} rm -f /flyway/sql/* || exit 1;
docker cp flyway.conf ${docker_container}:/flyway/conf/flyway.conf || exit 1;
docker cp migrations/ ${docker_container}:/flyway/sql || exit 1;

${docker_exec} [ -f baseline_migrated ]
baseline_migrated=$?

if [ ${baseline_migrated} -ne 0 ] ; then
    read -r -p "Is this the first time Flyway runs on this database? [y/N] " first_time
    if [[ ${first_time} =~ ^[Yy]$ ]]; then
        read -r -p "Does the database already contain data? [y/N] " contains_data
        if [[ ${contains_data} =~ ^[Yy]$ ]]; then
            ${docker_exec} ./flyway/flyway baseline || exit 1;
            ${docker_exec} touch baseline_migrated || exit 1;
        fi
    fi
fi

${docker_exec} ./flyway/flyway migrate || exit 1;