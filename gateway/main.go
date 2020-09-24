package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"github.com/ahmetb/go-linq"
	jwt "github.com/dgrijalva/jwt-go"
	"github.com/golang/protobuf/descriptor"
	"github.com/mkdir-sweden/padpal/gateway/auth"
	"github.com/mkdir-sweden/padpal/gateway/chat"
	"github.com/mkdir-sweden/padpal/gateway/protos/auth_v1"
	"github.com/mkdir-sweden/padpal/gateway/protos/chat_v1"
	rulepb "github.com/mkdir-sweden/padpal/gateway/protos/descriptors"
	"google.golang.org/grpc"
	metadata2 "google.golang.org/grpc/metadata"
	"google.golang.org/grpc/reflection"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/types/descriptorpb"
	_ "google.golang.org/protobuf/types/descriptorpb"
	"log"
	"net"
	"strings"
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

func withClientUnaryInterceptor() grpc.DialOption {
	m := &myObject{}
	return grpc.WithUnaryInterceptor(m.jwtValidator)
}

type myObject struct {
	// todo validate JWT
}

func (o *myObject) jwtValidator(
	ctx context.Context,
	method string,
	req interface{},
	reply interface{},
	cc *grpc.ClientConn,
	invoker grpc.UnaryInvoker,
	opts ...grpc.CallOption,
) error {

	start := time.Now()

	fileDescriptor, _ := descriptor.MessageDescriptorProto(req)
	q := linq.From(fileDescriptor.GetService()).Where(func(c interface{}) bool {
		sd := c.(*descriptorpb.ServiceDescriptorProto)
		return strings.HasPrefix(method, fmt.Sprintf("/%s.%s", fileDescriptor.GetPackage(), sd.GetName()))
	}).SelectMany(func(c interface{}) linq.Query {
		sd := c.(*descriptorpb.ServiceDescriptorProto)
		return linq.From(sd.GetMethod())
	}).SingleWith(func(c interface{}) bool {
		md := c.(*descriptorpb.MethodDescriptorProto)
		//xType := reflect.TypeOf(c)
		//xValue := reflect.ValueOf(c)
		//fmt.Println(xType, xValue)
		a := strings.Split(method, "/")[2]
		b := md.GetName()
		return strings.EqualFold(b, a)
	})

	md := q.(*descriptorpb.MethodDescriptorProto)
	ex := proto.GetExtension(md.Options, rulepb.E_Authorization)
	rule := ex.(*rulepb.Authorization)

	if rule.GetShouldValidate() {
		metadata, ok := metadata2.FromIncomingContext(ctx)
		if !ok {
			return errors.New("not ok")
		}
		authorization := metadata.Get("authorization")
		if len(authorization) == 0 {
			return errors.New("missing authorization header")
		}
		if len(authorization) != 1 {
			return errors.New(fmt.Sprintf("authorization header has %d lenght", len(authorization)))
		}

		splits := strings.Split(authorization[0], " ")

		if len(splits) != 2 {
			return errors.New(fmt.Sprintf("authorization header more then two splits, actual: %d", len(splits)))
		}

		tokenString := splits[1]

		pubKey := []byte("-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9SFtmaHLsT0mnNvDJ+zyXkKR5gJz21FGLOh1DDkIbANWZPWz0I3rR+Ltap6LUixwbUm8XvdUsmc4AxpEceblviw7oAz8t9Ju29/WsvmmRJA2NOdWOL88Ob7ghp4yDEGtGxVaoRlrnzNrdczAGIMpvLXggvrK49mu9llT8RH1Z3V0ZMQ8Akc3D6y+ddADvNEx7Vz2OTP0ISEr+7ZC4appC5dkTzyXePp8drZvsITe0ejMP4ZXo7UNgly7x+vNyzfnAv+6HgFSc72SBJncSjOhXuMJIg1f3PgQ1CHu2Yn+w2ZXNg5D7icSU1dv/6H1UTvg+YEAMi7dqpX8QpZWDxBWbQIDAQAB\n-----END CERTIFICATE-----")

		token, err := jwt.ParseWithClaims(tokenString, &jwt.StandardClaims{}, func(token *jwt.Token) (interface{}, error) {
			key, err := jwt.ParseRSAPublicKeyFromPEM(pubKey)
			if err != nil {
				return nil, err
			}

			if _, ok := token.Method.(*jwt.SigningMethodRSA); !ok {
				return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
			}

			return key, nil
		})

		if err != nil {
			panic(err)
		}

		if !token.Valid {
			panic(errors.New("token is not valid"))
		}

		if standard, ok := token.Claims.(*jwt.StandardClaims); ok {
			if standard.Issuer != "" {
				return errors.New("issues is not expected")
			}
			md := metadata2.Pairs("padpal-user-id", standard.Subject)
			ctx = metadata2.NewOutgoingContext(ctx, md)
		} else {
			return errors.New("token claims is wrong")
		}
	}

	elapsed := time.Since(start)
	log.Printf("Binomial took %s", elapsed)

	err := invoker(ctx, method, req, reply, cc, opts...)
	return err
}

func main() {

	//start := time.Now()
	//
	//c, d := descriptor.MessageDescriptorProto(&chatpb.GetRoomsWhereUserIsParticipatingRequest{})
	//a := chatpb.File_chat_service_proto.Options().ProtoReflect()
	//ex := proto.GetExtension(c.GetService()[0].Method[2].Options, rulepb.E_Unrestricted)
	//ex1 := proto.GetExtension(c.GetService()[0].Method[2].Options, rulepb.E_Rule)
	////ex2 := proto.GetExtension(ex1, rulepb.E_Rule)
	//p := ex1.(*rulepb.Rule)
	//elapsed := time.Since(start)
	//log.Printf("Binomial took %s", elapsed)
	//print(a, c, d, ex.(string), p.GetUnrestricted())

	flag.Parse()
	var opts []grpc.DialOption
	opts = append(opts, grpc.WithInsecure())
	opts = append(opts, withClientUnaryInterceptor())

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

	reflection.Register(s)
	chatpb.RegisterChatServiceService(s, chat.NewChatService(chatConn))
	authpb.RegisterAuthServiceService(s, auth.NewAuthService(authConn))
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
