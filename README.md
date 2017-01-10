# FAForever DB project

Contains a dockerfile to run our database in a contained environment, along with tools for managing the database.

## Set your Database up

Install [docker](http://docker.com).

**Make sure your port 3306 is not occupied**. Install and initialize the database:

    ./setup_db.sh

Now your FAF database is up and running and contains some dummy data (from `db-data.sql`)

If you want the database schema you can add the `-c` flag, this will dump the schema to `/tmp/dump.sql` on your host system.

## Update your Database

If you have an existing database which you need to update, run:

    ./migrate.sh faf-db

## Connect to your Database

To get a mysql session where you can execute queries conveniently, execute:

    docker exec -ti faf-db mysql -uroot -pbanana

