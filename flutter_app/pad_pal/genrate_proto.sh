mkdir packages/user_repository/lib/generated
protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/user_service.proto --plugin=protoc-gen-dart=/usr/local/bin/protoc-gen-dart --dart_out=grpc:packages/user_repository/lib/generated
mkdir packages/authentication_repository/lib/generated
protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/auth_service.proto --plugin=protoc-gen-dart=/usr/local/bin/protoc-gen-dart --dart_out=grpc:packages/authentication_repository/lib/generated

