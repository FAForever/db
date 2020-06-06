# FAForever DB project

This project contains the FAF database structure for the core FAF database used by the API and server. Other databases like for the forums or wiki are not part of this repository.

You can find a visual representation of the current schema on this projects [gitlab page](https://faforever.github.io/db/relationships.html).

## Usage with faf-stack
We highly recommended using [faf-stack](https://github.com/FAForever/faf-stack) to interact with the database.

### Preparing faf-stack
    git clone https://github.com/FAForever/faf-stack
    cd faf-stack
    cp .env.template .env
    cp -r config.template config

### Creating a new database
    scripts/init-db.sh

### Connecting to the database & check current version
In order to connect to the database using the mysql client, execute:

    docker exec -it faf-db mysql -D faf -uroot -pbanana

Where you have to replace `root` and `banana` with your custom credentials. (If you use the default configuration, you can omit the `-u` and `-p` parameter.)

You can now check the current version via running:

    select version from schema_version order by installed_rank desc limit 1

### Updating the database
First you need to pull the faf-stack repo and checkout the branch with the db version you want. Now you can migrate to the latest version using:

    docker-compose run --rm faf-db-migrations migrate

Updating the database is a one way street. Once you applied a migration, you cannot go back using a migration. If you want to do it manually you would need to undo the changes from the migrations and remove the version records in the table `schema_version`.


### Resetting the database
Sometimes you might end up in a broken state. Then it might the easiest way to delete your database. This can be achieved by deleting the docker container *and* removing the data directory.

    docker stop faf-db && docker rm faf-db && rm -rf ./data/faf-db

Now you can recreate the db as described above.


## Usage with plain Docker
**We highly advise you to start the db with faf-stack instead.**

If you do continue, you will lack the proper setup of database users and privileges. You also might run into compatibility issues with other services that are dependent on a specific db release. Please only continue, if you want to work on the db itself.

### Create a network
Create a network to connect the Docker containers to each other. _The `--link` method used in many tutorials is deprecated._

    docker network create faf

If you want other Docker containers to connect to the database, put them into the same network.

### Creating a new database
    docker run --network="faf" --network-alias="faf-db" -p 3306:3306 \
               -e MYSQL_ROOT_PASSWORD=banana \
               -e MYSQL_DATABASE=faf \
               -d --name faf-db \
               mysql:5.7

### Updating the database
In order to update an existing database to the newest schema version, first you need to build it from within the directory:

    docker build -t faf-db-migrations .

Once the docker image was built you can start it:

    docker run --network="faf" \
               -e FLYWAY_URL=jdbc:mysql://faf-db/faf?useSSL=false \
               -e FLYWAY_TABLE=schema_version \
               -e FLYWAY_USER=root \
               -e FLYWAY_PASSWORD=banana \
               faf-db-migrations migrate

## How to Contribute

To make changes to the database, add a new .sql file to the migrations folder. Each file needs to have a unique version prefix and be one version higher than the latest one.

For more information on how the migration works please consult the [Flyway tutorial](https://flywaydb.org/getstarted/how).

Please also follow our [general contribution guidelines](https://github.com/FAForever/db/wiki/How-to-Contribute).
