#!/usr/bin/env bash
set -e errexit
set -o pipefail

# Initializes the database at an old revision and executes all migration scripts since then
# To be executed in the project root

./restore.sh 4aaa0ab2fb6246efa0e08851c04b4dcbc14edfbc

expect <<EOF
    spawn ./migrate.sh faf-db faf_test 4aaa0ab2fb6246efa0e08851c04b4dcbc14edfbc
    expect {
        "Enter username: " { send "root\r"; exp_continue }
        "Enter password: " { send "banana\r"; exp_continue }
        eof
    }
EOF
