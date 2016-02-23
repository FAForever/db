# FAForever DB project

Contains a dockerfile to run our database in a contained environment, along with tools for managing the database.

# Installation

Get [docker](http://docker.com).

Quick overview of Docker can be found:
[Docker Quick Start Guide](https://docs.docker.com/engine/quickstart/)

Build the container using

    docker build -t faf-db .

Run using

    docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=<wanted_password> -e MYSQL_DATABASE=<db_name> -p 3306:3306 faf-db

Check to see if running by looking at the container and netstat

    docker ps
    netstat -atn | grep 3306

Find containers IP (Container ID can be found under docker ps)

    docker inspect <container_id> (IP is under IPAddress in NetworkSettings)

Import Structure

    docker exec -i faf-db mysql -uroot -p<wantedpassword> <db_name> < db-structure.sql

Import Data

    docker exec -i faf-db mysql -uroot -p faf_db  < db-data.sql

Now the database should be ready to go!