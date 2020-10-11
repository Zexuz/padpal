#!/usr/bin/env bash

[ -d "flutter_app/pad_pal/packages/game_repository/lib/generated" ] && rm -r flutter_app/pad_pal/packages/game_repository/lib/generated
[ -d "flutter_app/pad_pal/packages/authentication_repository/lib/generated" ] && rm -r flutter_app/pad_pal/packages/authentication_repository/lib/generated
[ -d "flutter_app/pad_pal/packages/social_repository/lib/generated" ] && rm -r flutter_app/pad_pal/packages/social_repository/lib/generated
[ -d "flutter_app/pad_pal/packages/notification_repository/lib/generated" ] && rm -r flutter_app/pad_pal/packages/notification_repository/lib/generated

[ ! -d "flutter_app/pad_pal/packages/game_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/game_repository/lib/generated
[ ! -d "flutter_app/pad_pal/packages/authentication_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/authentication_repository/lib/generated
[ ! -d "flutter_app/pad_pal/packages/social_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/social_repository/lib/generated
[ ! -d "flutter_app/pad_pal/packages/notification_repository/lib/generated" ] && mkdir flutter_app/pad_pal/packages/notification_repository/lib/generated

protoc -I ./includes/ -I ./protos/ --go_out=gateway/protos --go-grpc_out=gateway/protos \
  --go_opt=paths=source_relative \
  --go-grpc_opt=paths=source_relative \
  auth_v1/auth_service.proto social_v1/social_service.proto descriptors/rule.proto game_v1/game_service.proto notification_v1/notification_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/authentication_repository/lib/generated \
  auth_v1/auth_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/social_repository/lib/generated \
  social_v1/social_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/game_repository/lib/generated \
  game_v1/game_service.proto

protoc -I ./includes/ -I ./protos/ --dart_out=grpc:flutter_app/pad_pal/packages/notification_repository/lib/generated \
  notification_v1/notification_service.proto
