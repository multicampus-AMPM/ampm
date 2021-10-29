#!/usr/bin/env bash

docker-compose down
docker rm -f test
docker build -t test /home/test
docker-compose up -d --build
docker run --name test --net ampm_net test