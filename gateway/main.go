package main

import (
	"flag"
	"github.com/golang/protobuf/descriptor"
	"github.com/mkdir-sweden/padpal/gateway/auth"
	"github.com/mkdir-sweden/padpal/gateway/authpb"
	"github.com/mkdir-sweden/padpal/gateway/chat"
	"github.com/mkdir-sweden/padpal/gateway/chatpb"
	"github.com/mkdir-sweden/padpal/gateway/rulepb"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"
	_ "google.golang.org/protobuf/types/descriptorpb"
	"log"
	"net"
	"time"
)

const (
	port = ":50051"
)

// TODO
// Implement validation of proto files
// https://github.com/envoyproxy/protoc-gen-validate
// https://github.com/grpc-ecosystem/go-grpc-middleware

// TODO
// Validate JWT token here in the gateway

func main() {

	start := time.Now()

	c, d := descriptor.MessageDescriptorProto(&chatpb.GetRoomsWhereUserIsParticipatingRequest{})
	a := chatpb.File_chat_service_proto.Options().ProtoReflect()
	ex := proto.GetExtension(c.GetService()[0].Method[2].Options, rulepb.E_Unrestricted)
	ex1 := proto.GetExtension(c.GetService()[0].Method[2].Options, rulepb.E_Rule)
	//ex2 := proto.GetExtension(ex1, rulepb.E_Rule)
	p := ex1.(*rulepb.Rule)
	elapsed := time.Since(start)
	log.Printf("Binomial took %s", elapsed)
	print(a, c, d, ex.(string), p.GetUnrestricted())

	flag.Parse()
	var opts []grpc.DialOption
	opts = append(opts, grpc.WithInsecure())

	opts = append(opts, grpc.WithBlock())
	chatConn, err := grpc.Dial("localhost:5001", opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}

	authConn, err := grpc.Dial("localhost:5002", opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer chatConn.Close()
	defer authConn.Close()

	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()

	chatpb.RegisterChatServiceService(s, chat.NewChatService(chatConn))
	authpb.RegisterAuthServiceService(s, auth.NewAuthService(authConn))
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
