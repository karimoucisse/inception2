FROM debian:bookworm


RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-zcustom.cnf /etc/mysql/mariadb.conf.d/50-zcustom.cnf
RUN chown mysql:mysql /etc/mysql/mariadb.conf.d/50-zcustom.cnf

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql
RUN chmod -R 777 /var/lib
RUN chown -R mysql:mysql /run/mysqld

COPY conf/mariadb-conf.sh /tmp/mariadb-conf.sh


RUN chmod +x /tmp/mariadb-conf.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/mariadb-conf.sh"]
