mkdir packages\user_repository\lib\generated
mkdir packages\authentication_repository\lib\generated

protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/auth_service.proto --plugin=protoc-gen-dart=C:\flutter\.pub-cache\bin\protoc-gen-dart.bat --dart_out=grpc:packages/authentication_repository/lib/generated
protoc -I ./../../Padel.Runner/Protos ./../../Padel.Runner/Protos/user_service.proto --plugin=protoc-gen-dart=c:\flutter\.pub-cache\bin\protoc-gen-dart.bat --dart_out=grpc:packages/user_repository/lib/generated

