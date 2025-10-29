#!/bin/bash

htpasswd -B -c -b /etc/adminer/.htpasswd $DB_USER $DB_PASS

echo "Alias /$DB_USER /etc/adminer

<Directory /etc/adminer>
    Require all granted
    DirectoryIndex conf.php
</Directory>

<Location /$DB_USER>
    AuthType Basic
    AuthName \"Restricted Resource\"
    AuthBasicProvider file
    AuthUserFile /etc/adminer/.htpasswd
    Require valid-user
</Location>" > /etc/apache2/conf-available/adminer.conf


a2enconf adminer.conf

echo "ServerName localhost" >> /etc/apache2/apache2.conf

apachectl configtest

# service apache2 restart
echo "Adminer container is running ..."

exec apache2ctl -D FOREGROUND
