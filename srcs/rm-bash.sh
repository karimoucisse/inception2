#!/bin/bash

docker compose down

docker rmi -f $(docker image ls -qa)

docker volume rm -f $(docker volume ls -q)

rm -rf $HOME/data/mariadb/*
rm -rf $HOME/data/wordpress/*

# sudo docker exec -it wordpress bash

