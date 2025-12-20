#!/bin/bash

echo "Installing Wordpress ..."
echo "DB_NAME=$DB_NAME"
echo "DB_USER=$DB_USER"

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "❌ Missing environment variables: DB_NAME, DB_USER, or DB_PASS"
  exit 1
fi

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

sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

wp config create 	--allow-root \
					--dbname="$DB_NAME" \
					--dbuser="$DB_USER" \
					--dbpass="$DB_PASS" \
					--dbhost="$DB_HOST" \
					--path="$WORDPRESS_PATH"


# # install wordpress with the given title, admin username, password and email
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL" --allow-root
# #create a new user with the given username, email, password and role
# # Available role: 'administrator', 'editor', 'author', 'contributor', 'subscriber'
wp user create "$SIMPLE_USER" "$SIMPLE_USER_EMAIL" --user_pass="$SIMPLE_USER_PASS" --role="$USER_ROLE" --allow-root

echo "Wordpress container is running ..."
touch created
exec /usr/sbin/php-fpm8.2 -F


