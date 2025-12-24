FROM debian:bookworm

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install php php-fpm php-mysql wget tar mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/wordpress /run/php

RUN chmod -R 755 /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

COPY conf/wordpress-conf.sh /tmp/wordpress-conf.sh
RUN chmod +x /tmp/wordpress-conf.sh

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress-conf.sh" ]

