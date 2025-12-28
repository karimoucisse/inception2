#!/bin/bash
set -e

sed -i "s/server_name _;/server_name $DOMAIN_NAME;/g" /etc/nginx/sites-available/ssl-php.conf

exec nginx -g "daemon off;"
