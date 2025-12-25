FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-zcustom.cnf /etc/mysql/mariadb.conf.d/50-zcustom.cnf

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

COPY conf/mariadb-conf.sh /tmp/mariadb-conf.sh
RUN chmod +x /tmp/mariadb-conf.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/mariadb-conf.sh"]
