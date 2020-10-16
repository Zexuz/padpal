import 'package:authentication_repository/authentication_repository.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:game_repository/generated/game_v1/game_service.pbgrpc.dart';

class GameInfo{
  PublicGameInfo publicInfo;
  PrivateGameInfo privateInfo;
}

class GameRepository {
  GameRepository({GameClient gameClient, TokenManager tokenManager})
      : _gameClient = gameClient ?? GameClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  final GameClient _gameClient;
  final TokenManager _tokenManager;

  Future<List<GameInfo>> findGames(GameFilter filter) async {
    final callOptions =
        CallOptions(metadata: {'Authorization': "Bearer ${(await _tokenManager.getAccessToken()).token}"});

    final request = FindGamesRequest()..filter = filter;

    final call = _gameClient.findGames(request, options: callOptions);

    final protoRes = await call;
    return protoRes.games.map((e) => GameInfo()..publicInfo = e).toList();
  }

  Future<void> createGame(CreateGameRequest request) async {
    final callOptions =
        CallOptions(metadata: {'Authorization': "Bearer ${(await _tokenManager.getAccessToken()).token}"});


    final call = _gameClient.createGame(request, options: callOptions);

    await call;
  }
}
