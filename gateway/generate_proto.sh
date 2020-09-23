protoc -I /home/robin/code/padpal/Padel.Chat.Runner/Protos/ --go_out=../ --go-grpc_out=../ \
  --go_opt=paths=import \
  --go-grpc_opt=paths=import \
  chat_service.proto
