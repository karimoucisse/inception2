#!/bin/bash
docker compose down --rmi all --volumes --remove-orphans

# docker rmi -f $(docker image ls -qa)

# docker volume rm -f $(docker volume ls -q)

rm -rf $HOME/data/wordpress/*
sleep 5
rm -rf $HOME/data/mariadb/*

# sudo docker exec -it wordpress bash


# [mysqld]
# datadir = /var/lib/mysql
# socket  = /run/mysqld/mysqld.sock
# bind_address=*
# port = 3306
# user = mysql

# sudo mkdir -p /home/cisse/data/mariadb /home/cisse/data/wordpress
# sudo chown -R 999:999 /home/cisse/data/mariadb   # 999 est souvent l'ID de l'utilisateur mysql
# sudo chown -R 33:33 /home/cisse/data/wordpress   # 33 est l'ID de www-data

# SELECT User, Host FROM mysql.user;
