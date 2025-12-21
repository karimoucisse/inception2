#!/bin/bash

if [ -f $MARIADB_FILE_EXIST ]; then
  echo "MariaDB is already configured."
  exec mysqld --user=mysql
fi


echo "DB_NAME=$DB_NAME"
echo "DB_USER=$DB_USER"

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "❌ Missing environment variables: DB_NAME, DB_USER, or DB_PASS"
  exit 1
fi

echo "Starting MariaDB temporarily..."

# Créer les répertoires avec les bonnes permissions
# mkdir -p /var/lib/mysql
# mkdir -p /run/mysqld
# chown -R mysql:mysql /var/lib/mysql
# chown -R mysql:mysql /run/mysqld
# chmod 755 /var/lib/mysql
# chmod 755 /run/mysqld

# Initialiser la base de données
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Démarrer MariaDB temporairement pour la configuration
mysqld --user=mysql --skip-grant-tables &
MARIADB_PID=$!
sleep 3

# Configuration des bases et utilisateurs
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Arrêter le processus temporaire
kill $MARIADB_PID
sleep 2

# Marquer comme configuré
touch $MARIADB_FILE_EXIST

# Lancer MariaDB en tant que PID 1
exec mysqld --user=mysql
