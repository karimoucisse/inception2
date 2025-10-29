FROM debian:12.12

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install adminer

RUN mkdir -p /etc/apache2/conf-available

COPY conf/adminer-conf.sh /adminer-conf.sh

RUN chmod +x /adminer-conf.sh

ENTRYPOINT [ "/adminer-conf.sh" ]



