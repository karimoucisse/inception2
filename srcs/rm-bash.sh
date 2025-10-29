#!/bin/bash

sudo docker compose down

sudo docker rmi -f $(sudo docker image ls -qa)

sudo docker volume rm -f $(sudo docker volume ls -q)

# sudo docker exec -it wordpress bash

