protoc -I /home/robin/code/padpal/includes/ -I /home/robin/code/padpal/protos/ --go_out=gateway/protos --go-grpc_out=gateway/protos \
  --go_opt=paths=source_relative \
  --go-grpc_opt=paths=source_relative \
  auth_v1/auth_service.proto chat_v1/chat_service.proto descriptors/rule.proto user_v1/user_service.proto

