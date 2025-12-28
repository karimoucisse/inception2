FROM debian:bookworm

RUN apt-get -y update \
	&& apt-get -y install php php-fpm \
	php-mysql wget tar mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

RUN mkdir -p /var/www/wordpress

COPY conf/wordpress-conf.sh /tmp/wordpress-conf.sh
RUN chmod +x /tmp/wordpress-conf.sh

EXPOSE 9000

ENTRYPOINT [ "/tmp/wordpress-conf.sh" ]

