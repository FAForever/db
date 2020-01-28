#!/bin/bash
set -e

echo 'travis_fold:start:test_data'
echo '# Import test data'

echo "Insert test-data.sql for 1st run"
docker exec -i faf-db mysql -uroot -pbanana faf < test-data.sql || { echo "Test data failed"; exit 1; };

echo "Insert test-data.sql for 2nd run (ensure cleanup works as well)"
docker exec -i faf-db mysql -uroot -pbanana faf < test-data.sql || { echo "Test data failed"; exit 1; };

echo 'travis_fold:end:test_data'
