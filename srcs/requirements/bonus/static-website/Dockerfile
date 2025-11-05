FROM debian:12.12


RUN mkdir -p /etc/nginx/sites-enabled/ /etc/nginx/sites-available/ /etc/nginx/tls \
	/var/www/deezer

COPY content/deezer /var/www/deezer

COPY conf/website-nginx.conf /etc/nginx/sites-available/website-nginx.conf
RUN ln -s /etc/nginx/sites-available/website-nginx.conf /etc/nginx/sites-enabled/website-nginx.conf
