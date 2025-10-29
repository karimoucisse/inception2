#!/bin/bash

docker compose down

docker rmi -f $(docker image ls -qa)

docker volume rm -f $(docker volume ls -q)

# sudo docker exec -it wordpress bash

