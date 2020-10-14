import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:game_repository/generated/game_v1/game_service.pbgrpc.dart';

class GameRepository {
  GameRepository({GameClient gameClient, TokenManager tokenManager})
      : _gameClient = gameClient ?? GameClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  final GameClient _gameClient;
  final TokenManager _tokenManager;

  Future<List<PublicGameInfo>> findGames(GameFilter filter) async {
    final callOptions =
        CallOptions(metadata: {'Authorization': "Bearer ${(await _tokenManager.getAccessToken()).token}"});

    final request = FindGamesRequest()..filter = filter;

    final call = _gameClient.findGames(request, options: callOptions);

    final protoRes = await call;
    return protoRes.games;
  }

  Future<void> createGame(PublicGameInfo publicGameInfo, PrivateGameInfo privateGameInfo) async {
    final callOptions =
        CallOptions(metadata: {'Authorization': "Bearer ${(await _tokenManager.getAccessToken()).token}"});

    final request = CreateGameRequest()
      ..publicInfo = publicGameInfo
      ..privateInfo = privateGameInfo;

    final call = _gameClient.createGame(request, options: callOptions);

    await call;
  }
}
