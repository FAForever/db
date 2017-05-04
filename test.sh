#!/bin/bash
set -X

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
        exit 0
    fi
    sleep 1
    ((counter++))
done
echo '... faf-db is not running'
exit 1
