# FAForever DB project

Provides the Docker container and migration tools for a production-ready FAF database.

## Creating a new database

We highly recommended to use [faf-stack](https://github.com/FAForever/faf-stack) to create a new database container, like so:

    docker-compose up -d faf-db

## Updating the database

In order to update an existing database to the newest schema version, execute:

    docker exec -ti faf-db ./migrate.sh

## Connecting to the database

In order to connect to the database using the mysql client, execute:

    docker exec -ti faf-db mysql -uroot -pbanana

Where you have to replace `root` and `banana` with your custom credentials.
