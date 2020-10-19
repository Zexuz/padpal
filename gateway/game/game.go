package game

import (
	"context"
	"github.com/mkdir-sweden/padpal/gateway/hc"
	"github.com/mkdir-sweden/padpal/gateway/protos/game_v1"
	"google.golang.org/grpc"
)

func NewGameService(conn *grpc.ClientConn) *game_v1.GameService {
	client := &gameService{
		client: game_v1.NewGameClient(conn),
	}

	err := hc.AddChecker("game", conn)
	if err != nil {
		panic(err)
	}

	service := &game_v1.GameService{
		CreateGame:              client.CreateGame,
		FindGames:               client.FindGames,
		RequestToJoinGame:       client.RequestToJoinGame,
		AcceptRequestToJoinGame: client.AcceptRequestToJoinGame,
	}

	return service
}

type gameService struct {
	client game_v1.GameClient
}

func (s gameService) CreateGame(ctx context.Context, request *game_v1.CreateGameRequest) (*game_v1.CreateGameResponse, error) {
	return s.client.CreateGame(ctx, request)
}

func (s gameService) FindGames(ctx context.Context, request *game_v1.FindGamesRequest) (*game_v1.FindGamesResponse, error) {
	return s.client.FindGames(ctx, request)
}

func (s gameService) RequestToJoinGame(ctx context.Context, request *game_v1.RequestToJoinGameRequest) (*game_v1.RequestToJoinGameResponse, error) {
	return s.client.RequestToJoinGame(ctx, request)
}

func (s gameService) AcceptRequestToJoinGame(ctx context.Context, request *game_v1.AcceptRequestToJoinGameRequest) (*game_v1.AcceptRequestToJoinGameResponse, error) {
	return s.client.AcceptRequestToJoinGame(ctx, request)
}
