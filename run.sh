#!/usr/bin/env bash

docker build --build-arg USE_DEV_CERTS=true -t flareclient-mongo . | tee .out
if [ -z "$(grep 'Successfully built' .out )" ]; then echo "Error with docker build"; exit; fi

docker network create -d bridge ais20
docker rm -f flareclient-db
docker run \
    --network ais20 \
    --name flareclient-db \
    flareclient-db