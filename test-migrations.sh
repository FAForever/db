#!/bin/bash
set -e
echo -e 'travis_fold:start:Start Migration Base Test'
echo '# Start Migration Base Test...'
docker exec -i faf-db mysql --no-defaults -uroot -pbanana <<< "DROP DATABASE faf;"
docker exec -i faf-db mysql --no-defaults -uroot -pbanana <<< "CREATE DATABASE faf;"
echo 'Import dump ...'
docker exec -i faf-db mysql --no-defaults -uroot -pbanana faf < ./faf-db-dump/dump.sql
echo 'Migrate ...'
docker run --network="faf" \
           -e FLYWAY_URL=jdbc:mysql://faf-db/faf?useSSL=false \
           -e FLYWAY_USER=root \
           -e FLYWAY_PASSWORD=banana \
           faf-db-migrations migrate

echo '... Migration Test finished.'
echo -e 'travis_fold:end:Start Migration Base Test'
