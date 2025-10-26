FROM debian:12.12

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install nginx openssl

RUN mkdir -p /etc/nginx/sites-enabled/ /etc/nginx/sites-available/ /etc/nginx/tls \
	/var/www/site /var/www/wordpress

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -days 365 -out /etc/nginx/tls/tls.crt \
	-keyout /etc/nginx/tls/tls.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr"

COPY conf/ssl-php.conf /etc/nginx/sites-available/ssl-php.conf
RUN ln -s /etc/nginx/sites-available/ssl-php.conf /etc/nginx/sites-enabled/ssl-php.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]




