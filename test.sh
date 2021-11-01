#!/usr/bin/env bash

docker-compose down
docker rm -f inye-server
docker build -t inye /home/data-exporter/failure
docker-compose up -d --build
docker run --name inye-server --net ampm_net -p 8002:8002 inye