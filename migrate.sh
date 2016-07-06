#!/bin/bash

# This script helps running migration scripts.
# For a more sophisticated solution, I recommend Flyway

# After everything has been set up, this script can be used non-interactively like so:
# $0 <docker_container> <database> <current_revision>

if [ -z "$1" ]; then
    read -p "Name or ID of docker container: " docker_container
else
    docker_container=$1
    shift
fi

if [ -z "$1" ]; then
    read -p "Database to migrate: " db
else
    db=$1
    shift
fi

login_path=${db}
docker_cmd="docker exec -i ${docker_container}"
docker_mysql="${docker_cmd} mysql --login-path=${login_path}"
mytap_script="mytap.sql"
db_version_ddl="CREATE TABLE IF NOT EXISTS db_version (
      id INT NOT NULL AUTO_INCREMENT,
      script varchar(255),
      revision varchar(40) NOT NULL COMMENT 'The revision of the database after the script execution',
      execution_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this script was executed.',
      PRIMARY KEY (id)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"

function abort {
    echo $1
    exit 1
}

function get_db_revision {
    echo $(${docker_mysql} ${db} -B --disable-column-names -e "SELECT revision FROM db_version ORDER BY id DESC LIMIT 1");
}

function already_migrated {
    [ "$(${docker_mysql} ${db} -B --disable-column-names -e "SELECT 1 FROM db_version WHERE script = '${1}'")" == "1" ]
    return $?
}

# Install mysql_config_editor if necessary
if ! ${docker_cmd} bash -c "command -v mysql_config_editor" >/dev/null 2>&1; then
    read -p "I use mysql_config_editor to safely store the MySQL password inside the container.
However, I could not find mysql_config_editor in the container. Do you want me to install it? [Y/n] " answer

    case ${answer} in
        yes|[yY]|"")
            echo "This may take a while..."
            ${docker_cmd} apt-get update > /dev/null && ${docker_cmd} apt-get install libmysqlclient-dev > /dev/null\
                || abort "This did not work as expected. Please fix me."
            ;;
        *)
            echo "Then there's nothing I can do for you"
            exit 1
    esac
fi

# Store username/password in mysql config
if [ -z "$(${docker_cmd} mysql_config_editor print --login-path=${login_path})" ]; then
    echo "Please tell me your MySQL username and password. I will store them safely inside the docker container."

    read -p "Enter username: " username
    docker exec -it ${docker_container} mysql_config_editor set --login-path=${login_path} --password --user=${username}
    echo
    echo "Great. From now on you can use the following command to access your database:"
    echo
    echo "    docker exec -it ${docker_container} mysql --login-path=${login_path}"
    echo
fi

# Create the table db_version
${docker_mysql} ${db} -e "${db_version_ddl}" \
    || abort "I failed to create db_version"

# If no revision was passed as an argument, read from DB or user input
if [ -z "$1" ]; then
    db_revision=$(get_db_revision);
    if [ $? -ne 0 ]; then
        abort "I could not read the latest revision from the database"
    fi
    if [ -z "${db_revision}" ]; then
        echo "I've never seen this database before."
        read -p "Please tell me its current revision: " db_revision
    fi
else
    db_revision=$1
fi

# Load mytap.sql
${docker_mysql} ${db} < "${mytap_script}"

# Run migration scripts since last revision
for revision in $(git rev-list --reverse ${db_revision}^..HEAD); do
    for migration_script in $(find -name "*-${revision}.sql"); do
        if already_migrated $(basename ${migration_script}); then
            echo "Skipping already migrated file ${migration_script}"
            continue
        fi

        echo "  Applying ${migration_script} ..."
        ${docker_mysql} ${db} --skip-pager --batch --raw --skip-column-names --unbuffered  < "${migration_script}"
        if [ $? -ne 0 ]; then
            echo "Script could not be applied. Please fix it and continue using the command:"
            echo
            echo "    $0 ${docker_container} ${db} ${revision}"
            exit 1
        fi
        ${docker_mysql} ${db} -e "INSERT INTO db_version (script, revision)
            VALUES ('$(basename ${migration_script})', '$(git log -1 --pretty=format:'%H' ${migration_script})')" || abort "Could not update db_version"
    done
done

echo "Database is now at revision $(get_db_revision)"