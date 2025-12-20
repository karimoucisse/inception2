FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get -y install php-fpm php-mysql wget tar

RUN mkdir -p /var/www/wordpress /run/php

COPY conf/wordpress-conf.sh /wordpress-conf.sh
RUN chmod +x /wordpress-conf.sh

EXPOSE 9000

ENTRYPOINT [ "/wordpress-conf.sh" ]

