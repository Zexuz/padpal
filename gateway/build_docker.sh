#!/usr/bin/env bash

GIT_HASH=$(git rev-parse --short HEAD)

IMAGE_NAME=docker.pkg.github.com/mkdir-sweden/padpal/gateway

docker build . -t $IMAGE_NAME:latest
docker tag $IMAGE_NAME:latest $IMAGE_NAME:"$GIT_HASH"

docker push $IMAGE_NAME:latest
docker push $IMAGE_NAME:"$GIT_HASH"

docker rmi $IMAGE_NAME:latest
docker rmi $IMAGE_NAME:"$GIT_HASH"