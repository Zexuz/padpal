package interceptors

import (
	"context"
	"errors"
	"github.com/dgrijalva/jwt-go"
	chatpb "github.com/mkdir-sweden/padpal/gateway/protos/chat_v1"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
	"reflect"
	"testing"
	"time"
)

func createMetadata() context.Context {
	m := map[string]string{
		"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJleHAiOjE2MDA5NTM3OTcsInN1YiI6IjEifQ.ZZWo2lDF08QxC_2mXeYIFLzz-APV-mCHvv8J9Mn08Ogs3Ld2EB6teC5rEniETEN7OH4NdURBV8ZYm2Sw4ow7Q_cLexKH90LeV0NFMXHzQuMqkCPotN-JsL-E3z4_jzOJYIcXcWX3DAGJTsw_yG_NGknURo1undA9dZDXsyK6PGROTSbiF6dk9_LQP6k85MOJnVARlucIjIrg_2iVjgriyxpqYMJZJ51xY06nTwhtUqwCzJXMDOXDnDmAn0ZdgL5znuAbqHnOUJKlOb8vLAu13omWMLVeMrZ0BZmqVdR_kVqCGgSwy0DmyZxRZ_uwGECKTm-PYyvtgEy_RoLNsnAPQQ",
	}
	md := metadata.New(m)
	return metadata.NewIncomingContext(context.Background(), md)
}

/*
func Test_myObject_jwtValidator(t *testing.T) {

	jwt.TimeFunc = func() time.Time {
		return time.Unix(1600953000, 0)
	}

	type fields struct {
		publicKey []byte
	}
	type args struct {
		ctx     context.Context
		method  string
		req     interface{}
		reply   interface{}
		cc      *grpc.ClientConn
		invoker grpc.UnaryInvoker
		opts    []grpc.CallOption
	}
	tests := []struct {
		name    string
		fields  fields
		args    args
		wantErr bool
	}{
		{
			name: "set padpal-user-id",
			fields: struct {
				publicKey []byte
			}{
				publicKey: []byte("-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9SFtmaHLsT0mnNvDJ+zyXkKR5gJz21FGLOh1DDkIbANWZPWz0I3rR+Ltap6LUixwbUm8XvdUsmc4AxpEceblviw7oAz8t9Ju29/WsvmmRJA2NOdWOL88Ob7ghp4yDEGtGxVaoRlrnzNrdczAGIMpvLXggvrK49mu9llT8RH1Z3V0ZMQ8Akc3D6y+ddADvNEx7Vz2OTP0ISEr+7ZC4appC5dkTzyXePp8drZvsITe0ejMP4ZXo7UNgly7x+vNyzfnAv+6HgFSc72SBJncSjOhXuMJIg1f3PgQ1CHu2Yn+w2ZXNg5D7icSU1dv/6H1UTvg+YEAMi7dqpX8QpZWDxBWbQIDAQAB\n-----END CERTIFICATE-----"),
			},
			args: struct {
				ctx     context.Context
				method  string
				req     interface{}
				reply   interface{}
				cc      *grpc.ClientConn
				invoker grpc.UnaryInvoker
				opts    []grpc.CallOption
			}{
				ctx:    createMetadata(),
				method: "/chat.v1.ChatService/SendMessage",
				req:    &chatpb.SendMessageRequest{},
				reply:  &chatpb.SendMessageRequest{},
				cc:     nil,
				invoker: func(ctx context.Context, method string, req, reply interface{}, cc *grpc.ClientConn, opts ...grpc.CallOption) error {
					md, ok := metadata.FromIncomingContext(ctx)
					if !ok {
						return errors.New("ok was false")
					}

					if md.Get("padpal-user-id")[0] != "1" {
						return errors.New("padpal-user-id is not set")
					}

					return nil
				},
				opts: nil,
			},
			wantErr: false,
		},
		{
			name: "ErrMissingAuthorizationOption",
			fields: struct {
				publicKey []byte
			}{
				publicKey: []byte("-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9SFtmaHLsT0mnNvDJ+zyXkKR5gJz21FGLOh1DDkIbANWZPWz0I3rR+Ltap6LUixwbUm8XvdUsmc4AxpEceblviw7oAz8t9Ju29/WsvmmRJA2NOdWOL88Ob7ghp4yDEGtGxVaoRlrnzNrdczAGIMpvLXggvrK49mu9llT8RH1Z3V0ZMQ8Akc3D6y+ddADvNEx7Vz2OTP0ISEr+7ZC4appC5dkTzyXePp8drZvsITe0ejMP4ZXo7UNgly7x+vNyzfnAv+6HgFSc72SBJncSjOhXuMJIg1f3PgQ1CHu2Yn+w2ZXNg5D7icSU1dv/6H1UTvg+YEAMi7dqpX8QpZWDxBWbQIDAQAB\n-----END CERTIFICATE-----"),
			},
			args: struct {
				ctx     context.Context
				method  string
				req     interface{}
				reply   interface{}
				cc      *grpc.ClientConn
				invoker grpc.UnaryInvoker
				opts    []grpc.CallOption
			}{
				ctx:    createMetadata(),
				method: "/chat.v1.ChatService/SendMessage",
				req:    &struct{}{},
				reply:  &struct{}{},
				cc:     nil,
				invoker: func(ctx context.Context, method string, req, reply interface{}, cc *grpc.ClientConn, opts ...grpc.CallOption) error {
					md, ok := metadata.FromIncomingContext(ctx)
					if !ok {
						return errors.New("ok was false")
					}

					if md.Get("padpal-user-id")[0] != "1" {
						return errors.New("padpal-user-id is not set")
					}

					return nil
				},
				opts: nil,
			},
			wantErr: true,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			o := &myObject{
				publicKey: tt.fields.publicKey,
			}
			if err := o.jwtValidator(tt.args.ctx, tt.args.method, tt.args.req, tt.args.reply, tt.args.cc, tt.args.invoker, tt.args.opts...); (err != nil) != tt.wantErr {
				t.Errorf("jwtValidator() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}
*/

func Test_myObject_jwtValidator(t *testing.T) {
	jwt.TimeFunc = func() time.Time {
		return time.Unix(1600953000, 0)
	}

	type fields struct {
		publicKey []byte
	}
	type args struct {
		ctx     context.Context
		req     interface{}
		info    *grpc.UnaryServerInfo
		handler grpc.UnaryHandler
	}
	tests := []struct {
		name     string
		fields   fields
		args     args
		wantResp interface{}
		wantErr  bool
	}{
		{
			name: "set padpal-user-id",
			fields: struct {
				publicKey []byte
			}{
				publicKey: []byte("-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9SFtmaHLsT0mnNvDJ+zyXkKR5gJz21FGLOh1DDkIbANWZPWz0I3rR+Ltap6LUixwbUm8XvdUsmc4AxpEceblviw7oAz8t9Ju29/WsvmmRJA2NOdWOL88Ob7ghp4yDEGtGxVaoRlrnzNrdczAGIMpvLXggvrK49mu9llT8RH1Z3V0ZMQ8Akc3D6y+ddADvNEx7Vz2OTP0ISEr+7ZC4appC5dkTzyXePp8drZvsITe0ejMP4ZXo7UNgly7x+vNyzfnAv+6HgFSc72SBJncSjOhXuMJIg1f3PgQ1CHu2Yn+w2ZXNg5D7icSU1dv/6H1UTvg+YEAMi7dqpX8QpZWDxBWbQIDAQAB\n-----END CERTIFICATE-----"),
			},
			args: struct {
				ctx     context.Context
				req     interface{}
				info    *grpc.UnaryServerInfo
				handler grpc.UnaryHandler
			}{
				ctx: createMetadata(),
				req: &chatpb.SendMessageRequest{},
				info: &grpc.UnaryServerInfo{
					Server:     nil,
					FullMethod: "/chat.v1.ChatService/SendMessage",
				},
				handler: func(ctx context.Context, req interface{}) (interface{}, error) {
					md, ok := metadata.FromOutgoingContext(ctx)
					if !ok {
						return nil, errors.New("ok was false")
					}

					if md.Get("padpal-user-id")[0] != "1" {
						return nil, errors.New("padpal-user-id is not set")
					}

					return nil, nil
				},
			},
			wantResp: nil,
			wantErr:  false,
		},
		{
			name: "ErrMissingAuthorizationOption",
			fields: struct {
				publicKey []byte
			}{
				publicKey: []byte("-----BEGIN CERTIFICATE-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA9SFtmaHLsT0mnNvDJ+zyXkKR5gJz21FGLOh1DDkIbANWZPWz0I3rR+Ltap6LUixwbUm8XvdUsmc4AxpEceblviw7oAz8t9Ju29/WsvmmRJA2NOdWOL88Ob7ghp4yDEGtGxVaoRlrnzNrdczAGIMpvLXggvrK49mu9llT8RH1Z3V0ZMQ8Akc3D6y+ddADvNEx7Vz2OTP0ISEr+7ZC4appC5dkTzyXePp8drZvsITe0ejMP4ZXo7UNgly7x+vNyzfnAv+6HgFSc72SBJncSjOhXuMJIg1f3PgQ1CHu2Yn+w2ZXNg5D7icSU1dv/6H1UTvg+YEAMi7dqpX8QpZWDxBWbQIDAQAB\n-----END CERTIFICATE-----"),
			},
			args: struct {
				ctx     context.Context
				req     interface{}
				info    *grpc.UnaryServerInfo
				handler grpc.UnaryHandler
			}{
				ctx: createMetadata(),
				req: &struct{}{},
				info: &grpc.UnaryServerInfo{
					Server:     nil,
					FullMethod: "/chat.v1.ChatService/SendMessage",
				},
				handler: func(ctx context.Context, req interface{}) (interface{}, error) {
					md, ok := metadata.FromOutgoingContext(ctx)
					if !ok {
						return nil, errors.New("ok was false")
					}

					if md.Get("padpal-user-id")[0] != "1" {
						return nil, errors.New("padpal-user-id is not set")
					}

					return nil, nil
				},
			},
			wantResp: nil,
			wantErr:  true,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			o := &myObject{
				publicKey: tt.fields.publicKey,
			}
			gotResp, err := o.jwtValidator(tt.args.ctx, tt.args.req, tt.args.info, tt.args.handler)
			if (err != nil) != tt.wantErr {
				t.Errorf("jwtValidator() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(gotResp, tt.wantResp) {
				t.Errorf("jwtValidator() gotResp = %v, want %v", gotResp, tt.wantResp)
			}
		})
	}
}
