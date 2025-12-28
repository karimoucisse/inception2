#!/bin/bash
set -e

if [ -f $MARIADB_FILE_EXIST ]; then
   echo "MariaDB est configurée."
   exec mysqld --user=mysql
fi

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "Error: Missing environment variables: DB_NAME, DB_USER, or DB_PASS"
  exit 1
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm
fi

mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# SELECT User, Host FROM mysql.user;
echo "MariaDB is configured."

touch $MARIADB_FILE_EXIST
exec mysqld --user=mysql
