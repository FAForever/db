# FAForever DB project

This project contains the FAF database structure for the core faf database used by API and server. (Other databases like forums or wiki are not part of this repository.)

## Usage with faf-stack
We highly recommended to use [faf-stack](https://github.com/FAForever/faf-stack) to interact with the database!

### Creating a new database
    docker-compose up -d faf-db

### Updating the database
In order to update an existing database to the newest schema version, execute:

    docker-compose run faf-db-migrations migrate

### Connecting to the database
In order to connect to the database using the mysql client, execute:

    docker exec -ti faf-db mysql -uroot -pbanana

Where you have to replace `root` and `banana` with your custom credentials.


## Usage with plain docker

### Create a network
Create a network to connect the docker containers to each other. The old `--link` method is deprecated.

    docker network create faf

If you want to connect other docker containers to connect to the database, put them into the same network.

### Creating a new database
    docker run --network="faf" --network-alias="faf-db" -p 3306:3306 \
               -e MYSQL_ROOT_PASSWORD=banana \
               -e MYSQL_DATABASE=faf \
               -d --name faf-db \
               mysql:5.7

### Updating the database
In order to update an existing database to the newest schema version, execute:

    docker run --network="faf" \
               -e FLYWAY_URL=jdbc:mysql://faf-db/faf?useSSL=false \
               -e FLYWAY_USER=root \
               -e FLYWAY_PASSWORD=banana \
               faf-db-migrations migrate

## How to Contribute

To make changes to the database, add a new .sql file to the migrations folder. Each file needs to have a unique version prefix and be one version higher than the latest one.

For more information how the migration works please consult the [flyway tutorial](https://flywaydb.org/getstarted/how).

Please also follow our [general contribution guidelines](https://github.com/FAForever/db/wiki/How-to-Contribute).
