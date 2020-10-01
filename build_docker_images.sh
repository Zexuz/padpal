#!/usr/bin/env bash

docker build -f Dockerfile.chat . -t docker.pkg.github.com/mkdir-sweden/padpal/chat:latest && docker push docker.pkg.github.com/mkdir-sweden/padpal/chat:latest
docker build -f Dockerfile.identity . -t docker.pkg.github.com/mkdir-sweden/padpal/identity:latest && docker push docker.pkg.github.com/mkdir-sweden/padpal/identity:latest
docker build -f Dockerfile.notification . -t docker.pkg.github.com/mkdir-sweden/padpal/notification:latest && docker push docker.pkg.github.com/mkdir-sweden/padpal/notification:latest
