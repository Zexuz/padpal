package game

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/game_v1"
	"google.golang.org/grpc"
)

func NewGameService(conn *grpc.ClientConn) *gamepb.GameService {
	client := &gameService{
		client: gamepb.NewGameClient(conn),
	}

	err := hc.AddChecker("game", conn)
	if err != nil {
		panic(err)
	}

	service := &gamepb.GameService{
		CreateGame:        client.CreateGame,
		FindGames:         client.FindGames,
		RequestToJoinGame: client.RequestToJoinGame,
	}

	return service
}

type gameService struct {
	client gamepb.GameClient
}

func (s gameService) CreateGame(ctx context.Context, request *gamepb.CreateGameRequest) (*gamepb.CreateGameResponse, error) {
	return s.client.CreateGame(ctx, request)
}

func (s gameService) FindGames(ctx context.Context, request *gamepb.FindGamesRequest) (*gamepb.FindGamesResponse, error) {
	return s.client.FindGames(ctx, request)
}

func (s gameService) RequestToJoinGame(ctx context.Context, request *gamepb.RequestToJoinGameRequest) (*gamepb.RequestToJoinGameResponse, error) {
	return s.client.RequestToJoinGame(ctx, request)
}
