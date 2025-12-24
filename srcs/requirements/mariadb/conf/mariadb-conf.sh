#!/bin/bash
set -e

if [ -f $MARIADB_FILE_EXIST ]; then
   echo "MariaDB est configurée."
   exec mysqld --user=mysql
fi

# Vérification des variables d'environnement
if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "Erreur: Variables DB_NAME, DB_USER, ou DB_PASS manquantes."
  exit 1
fi

# Initialisation du répertoire de données si vide
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation du répertoire de données..."
    # On lance l'initialisation SANS sudo, mais le script est déjà root
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm
fi

# Lancer MariaDB temporairement pour la configuration
mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "MariaDB est configurée."

touch $MARIADB_FILE_EXIST
# Lancer le processus principal au premier plan
exec mysqld --user=mysql
