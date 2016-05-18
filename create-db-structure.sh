#!/bin/sh
rm db-structure.sql
docker exec faf-db mysqldump -pbanana --no-data --skip-add-drop-table faf_test > db-structure.sql
sed -i 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' db-structure.sql
