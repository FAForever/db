#!/bin/bash
set -e
echo -e 'travis_fold:start:Start Migration Base Test'
echo '# Start Migration Base Test...'
docker exec -i faf-db mysql -uroot -pbanana <<< "DROP DATABASE faf;"
docker exec -i faf-db mysql -uroot -pbanana <<< "CREATE DATABASE faf;"
echo 'Import dump ...'
docker exec -i faf-db mysql -uroot -pbanana faf < ./faf-db-dump/dump.sql
echo 'Migrate ...'
docker exec -i faf-db ./migrate.sh

echo '... Migration Test finished.'
echo -e 'travis_fold:end:Start Migration Base Test'
