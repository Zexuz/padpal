#!/usr/bin/env bash

[ ! -d "flutter_app/pad_pal/packages/user_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/user_repository/lib/generated
[ ! -d "flutter_app/pad_pal/packages/authentication_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/authentication_repository/lib/generated
[ ! -d "flutter_app/pad_pal/packages/chat_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/chat_repository/lib/generated


protoc -I ./includes/ -I ./protos/ --go_out=gateway/protos --go-grpc_out=gateway/protos \
  --go_opt=paths=source_relative \
  --go-grpc_opt=paths=source_relative \
  auth_v1/auth_service.proto chat_v1/chat_service.proto descriptors/rule.proto user_v1/user_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/authentication_repository/lib/generated \
  auth_v1/auth_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/chat_repository/lib/generated \
  chat_v1/chat_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/user_repository/lib/generated \
  user_v1/user_service.proto


