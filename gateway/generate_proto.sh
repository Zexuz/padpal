protoc -I /home/robin/code/padpal/Padel.Chat.Runner/Protos/ -I /home/robin/code/padpal/gateway/includes/ --go_out=../ --go-grpc_out=../ \
  --go_opt=paths=import \
  --go-grpc_opt=paths=import \
  chat_service.proto rule.proto

protoc -I /home/robin/code/padpal/Padel.Identity.Runner/Protos/ --go_out=../ --go-grpc_out=../ \
  --go_opt=paths=import \
  --go-grpc_opt=paths=import \
  auth_service.proto

protoc -I /home/robin/code/padpal/Padel.Identity.Runner/Protos/ --go_out=../ --go-grpc_out=../ \
  --go_opt=paths=import \
  --go-grpc_opt=paths=import \
  user_service.proto
