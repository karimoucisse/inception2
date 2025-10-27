FROM debian:12.12

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/50-zcustom.cnf /etc/mysql/mariadb.conf.d/50-zcustom.cnf

COPY conf/mariadb-conf.sh /mariadb-conf.sh

RUN chmod +x /mariadb-conf.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb-conf.sh"]

