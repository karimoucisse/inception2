#!/bin/bash
set -e

echo "Installing Wordpress ..."

if [ -f $WORDPRESS_FILE_EXIST ]; then
   echo "Wordpress is already configured."
   exec /usr/sbin/php-fpm8.2 -F
fi

echo "DB_NAME=$DB_NAME"
echo "DB_USER=$DB_USER"

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "Missing environment variables: DB_NAME, DB_USER, or DB_PASS"
  exit 1
fi

if [ -z "$WORDPRESS_PATH" ] || [ -z "$DB_HOST" ] || [ -z "$DOMAIN_NAME" ]; then
  echo "Missing environment variables: WORDPRESS_PATH, DB_HOST, or DOMAIN_NAME"
  exit 1
fi

if [ -z "$WP_TITLE" ] || [ -z "$ADMIN_USER" ] || [ -z "$ADMIN_PASS" ]; then
  echo "Missing environment variables: WP_TITLE, ADMIN_USER, or ADMIN_PASS"
  exit 1
fi

if [ -z "$ADMIN_EMAIL" ] || [ -z "$SIMPLE_USER" ] || [ -z "$SIMPLE_USER_EMAIL" ] || [ -z "$SIMPLE_USER_PASS" ] || [ -z "$USER_ROLE" ]; then
  echo "Missing environment variables: SIMPLE_USER, SIMPLE_USER_EMAIL, SIMPLE_USER_PASS, or USER_ROLE"
  exit 1
fi

echo "Waiting for $DB_HOST..."
while ! mariadb -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "MariaDB is not ready yet... (sleeping 2s)"
    sleep 2
done

echo "MariaDB is online! Continuing installation."
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
cp -r wordpress/* $WORDPRESS_PATH
rm -rf wordpress
rm -rf latest.tar.gz

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 $WORDPRESS_PATH

echo "Installing Wordpress CLI ..."
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

echo "wp-config.php creation"

wp config create 	--allow-root \
					--dbname="$DB_NAME" \
					--dbuser="$DB_USER" \
					--dbpass="$DB_PASS" \
					--dbhost="$DB_HOST" \
					--path="$WORDPRESS_PATH"

echo "Wordpress configuration file created."


wp core install --url="$DOMAIN_NAME" --path="$WORDPRESS_PATH" --title="$WP_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL" --allow-root
wp user create "$SIMPLE_USER" "$SIMPLE_USER_EMAIL" --path="$WORDPRESS_PATH" --user_pass="$SIMPLE_USER_PASS" --role="$USER_ROLE" --allow-root

echo "Wordpress container is running ..."
touch $WORDPRESS_FILE_EXIST
exec /usr/sbin/php-fpm8.2 -F


