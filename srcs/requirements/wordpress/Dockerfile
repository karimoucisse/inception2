FROM debian:bookworm

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install php php-fpm php-mysql wget tar mariadb-client

RUN mkdir -p /var/www/wordpress /run/php

COPY conf/wordpress-conf.sh /wordpress-conf.sh
RUN chmod +x /wordpress-conf.sh

EXPOSE 9000

ENTRYPOINT [ "/wordpress-conf.sh" ]

