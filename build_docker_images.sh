#!/usr/bin/env bash

GIT_HASH=$(git rev-parse --short HEAD)

REPO=docker.pkg.github.com/mkdir-sweden/padpal

docker build -f Dockerfile.social . -t $REPO/social:"$GIT_HASH"
docker build -f Dockerfile.identity . -t $REPO/identity:"$GIT_HASH"
docker build -f Dockerfile.notification . -t $REPO/notification:"$GIT_HASH"

docker tag $REPO/social:"$GIT_HASH" $REPO/social:latest
docker tag $REPO/identity:"$GIT_HASH" $REPO/identity:latest
docker tag $REPO/notification:"$GIT_HASH" $REPO/notification:latest

docker push $REPO/social:latest
docker push $REPO/identity:latest
docker push $REPO/notification:latest
docker push $REPO/social:"$GIT_HASH"
docker push $REPO/identity:"$GIT_HASH"
docker push $REPO/notification:"$GIT_HASH"
