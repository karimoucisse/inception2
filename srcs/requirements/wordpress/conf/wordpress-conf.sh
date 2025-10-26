#!/bin/bash


echo "Installing Wordpress ..."
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
cp -r wordpress/* /var/www/wordpress/
rm -rf wordpress
rm -rf latest.tar.gz
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "Installing Wordpress CLI ..."
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F
