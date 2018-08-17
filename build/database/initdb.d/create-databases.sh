#!/bin/bash
set -e

databases=$(echo $MYSQL_DATABASES | tr "," "\n")

echo "Creating databases $MYSQL_DATABASES"

mysql=( mysql --protocol=socket -uroot )
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
fi

user=$MYSQL_USER
pass=$MYSQL_PASSWORD

for db in $databases
do
    echo "Creating database $db"
    echo "CREATE DATABASE IF NOT EXISTS \`$db\`" | "${mysql[@]}"
done

echo "Creating user $user"
echo "CREATE USER IF NOT EXISTS '$user'@'%' IDENTIFIED BY '$pass' ;" | "${mysql[@]}"

for db in $databases
do
    echo "Setting permissions for user $user on database $db"
    echo "GRANT ALL ON \`$db\`.* TO '$user'@'%';" | "${mysql[@]}"
done

echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
