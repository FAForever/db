#!/bin/bash
set -e

echo 'travis_fold:start:bootstrap'
echo '# Build & Run Docker Container'
docker build -t faf-db-migrations .
docker network create faf
docker run --network="faf" --network-alias="faf-db" -p 3306:3306 \
           -e MYSQL_ROOT_PASSWORD=banana \
           -e MYSQL_DATABASE=faf \
           -d --name faf-db \
           mysql:5.7

echo -n 'Waiting on faf-db '
counter=1
# wait 5 minutes on docker container
while [ $counter -le 300 ]
do
    if docker exec -it faf-db sh -c "mysqladmin ping -h 127.0.0.1 -uroot -pbanana" &> /dev/null; then
        echo 'travis_fold:end:bootstrap'

        # run flyway migrations
        docker run --network="faf" \
                   -e FLYWAY_URL=jdbc:mysql://faf-db/faf?useSSL=false \
                   -e FLYWAY_USER=root \
                   -e FLYWAY_PASSWORD=banana \
                   faf-db-migrations migrate

        exit 0
    fi
    echo -n "."
    sleep 1
    ((counter++))
done
echo 'Error: faf-db is not running after 5 minute timeout'
echo 'travis_fold:end:bootstrap'
exit 1
