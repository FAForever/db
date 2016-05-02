# FAForever DB project

Contains a dockerfile to run our database in a contained environment, along with tools for managing the database.

# Installation

Get [docker](http://docker.com).

Build the container from the FAForever/db-directory using

    docker build -t faf-db .

Run using

    docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=<wanted_password> faf-db

Create database

    docker exec -i faf-db mysql -uroot -p<wantedpassword> -e "create database <wanteddatabase>"

Import structure

    docker exec -i faf-db mysql -uroot -p<wantedpassword> <wanteddatabase> < db-structure.sql

Import data

    docker exec -i faf-db mysql -uroot -p<wantedpassword> <wanteddatabase> < db-data.sql


# Side notes

Using the docker build process will provide you with the required software versions. If you decide to run the database outside docker you will require a MySQL version >= 5.6.5.