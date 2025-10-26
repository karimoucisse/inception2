FROM debian:12.12

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install nginx openssl

RUN mkdir -p /etc/nginx/sites-enabled/ /etc/nginx/sites-available/ /etc/nginx/tls \
	/var/www/site /var/www/wordpress /etc/nginx/snippets

RUN openssl req -x509 -nodes -days 365 -out /etc/nginx/tls/tls.crt \
	-keyout /etc/nginx/tls/tls.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=localhost"

COPY conf/ssl-php.conf /etc/nginx/sites-available/ssl-php.conf
RUN ln -s /etc/nginx/sites-available/ssl-php.conf /etc/nginx/sites-enabled/ssl-php.conf

CMD ["nginx", "-g", "daemon off;"]




