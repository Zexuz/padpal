#!/usr/bin/env bash

[ ! -d "packages/user_repository/lib/generated" ] && mkdir packages/user_repository/lib/generated
[ ! -d "packages/authentication_repository/lib/generated" ] && mkdir packages/authentication_repository/lib/generated
[ ! -d "packages/chat_repository/lib/generated" ] && mkdir packages/chat_repository/lib/generated

protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/auth_service.proto --dart_out=grpc:packages/authentication_repository/lib/generated
protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/user_service.proto --dart_out=grpc:packages/user_repository/lib/generated
protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/chat_service.proto --dart_out=grpc:packages/chat_repository/lib/generated

