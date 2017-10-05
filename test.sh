#!/bin/bash
set -e

echo -e 'travis_fold:start:docker'
echo '# Build & Run Docker Container'
docker build -t faf-db .
docker run -d --name faf-db -e MYSQL_ROOT_PASSWORD=banana -p 3306:3306 faf-db

echo 'wait on faf-db ...'
counter=1
# wait 5 minutes on docker container
while [ $counter -le 300 ]
do
    status=$(docker inspect --format='{{json .State.Health.Status}}' faf-db)
    expected='"healthy"'
    if [ $status == $expected ]; then
        echo '... faf-db is running'
        echo -en 'travis_fold:end:docker\\r'
        exit 0
    fi
    sleep 1
    ((counter++))
done
docker logs faf-db
echo '... faf-db is not running'
echo -e 'travis_fold:end:docker'
exit 1
