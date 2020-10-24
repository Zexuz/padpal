///
//  Generated code. Do not modify.
//  source: game_v1/game_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'game_service.pb.dart' as $0;
export 'game_service.pb.dart';

class GameClient extends $grpc.Client {
  static final _$createGame =
      $grpc.ClientMethod<$0.CreateGameRequest, $0.CreateGameResponse>(
          '/game.v1.Game/CreateGame',
          ($0.CreateGameRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateGameResponse.fromBuffer(value));
  static final _$findGames =
      $grpc.ClientMethod<$0.FindGamesRequest, $0.FindGamesResponse>(
          '/game.v1.Game/FindGames',
          ($0.FindGamesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FindGamesResponse.fromBuffer(value));
  static final _$requestToJoinGame = $grpc.ClientMethod<
          $0.RequestToJoinGameRequest, $0.RequestToJoinGameResponse>(
      '/game.v1.Game/RequestToJoinGame',
      ($0.RequestToJoinGameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RequestToJoinGameResponse.fromBuffer(value));
  static final _$acceptRequestToJoinGame = $grpc.ClientMethod<
          $0.AcceptRequestToJoinGameRequest,
          $0.AcceptRequestToJoinGameResponse>(
      '/game.v1.Game/AcceptRequestToJoinGame',
      ($0.AcceptRequestToJoinGameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.AcceptRequestToJoinGameResponse.fromBuffer(value));

  GameClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.CreateGameResponse> createGame(
      $0.CreateGameRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createGame, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.FindGamesResponse> findGames(
      $0.FindGamesRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$findGames, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.RequestToJoinGameResponse> requestToJoinGame(
      $0.RequestToJoinGameRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$requestToJoinGame, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.AcceptRequestToJoinGameResponse>
      acceptRequestToJoinGame($0.AcceptRequestToJoinGameRequest request,
          {$grpc.CallOptions options}) {
    final call = $createCall(
        _$acceptRequestToJoinGame, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class GameServiceBase extends $grpc.Service {
  $core.String get $name => 'game.v1.Game';

  GameServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateGameRequest, $0.CreateGameResponse>(
        'CreateGame',
        createGame_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateGameRequest.fromBuffer(value),
        ($0.CreateGameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FindGamesRequest, $0.FindGamesResponse>(
        'FindGames',
        findGames_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FindGamesRequest.fromBuffer(value),
        ($0.FindGamesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestToJoinGameRequest,
            $0.RequestToJoinGameResponse>(
        'RequestToJoinGame',
        requestToJoinGame_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestToJoinGameRequest.fromBuffer(value),
        ($0.RequestToJoinGameResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AcceptRequestToJoinGameRequest,
            $0.AcceptRequestToJoinGameResponse>(
        'AcceptRequestToJoinGame',
        acceptRequestToJoinGame_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AcceptRequestToJoinGameRequest.fromBuffer(value),
        ($0.AcceptRequestToJoinGameResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateGameResponse> createGame_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateGameRequest> request) async {
    return createGame(call, await request);
  }

  $async.Future<$0.FindGamesResponse> findGames_Pre($grpc.ServiceCall call,
      $async.Future<$0.FindGamesRequest> request) async {
    return findGames(call, await request);
  }

  $async.Future<$0.RequestToJoinGameResponse> requestToJoinGame_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RequestToJoinGameRequest> request) async {
    return requestToJoinGame(call, await request);
  }

  $async.Future<$0.AcceptRequestToJoinGameResponse> acceptRequestToJoinGame_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AcceptRequestToJoinGameRequest> request) async {
    return acceptRequestToJoinGame(call, await request);
  }

  $async.Future<$0.CreateGameResponse> createGame(
      $grpc.ServiceCall call, $0.CreateGameRequest request);
  $async.Future<$0.FindGamesResponse> findGames(
      $grpc.ServiceCall call, $0.FindGamesRequest request);
  $async.Future<$0.RequestToJoinGameResponse> requestToJoinGame(
      $grpc.ServiceCall call, $0.RequestToJoinGameRequest request);
  $async.Future<$0.AcceptRequestToJoinGameResponse> acceptRequestToJoinGame(
      $grpc.ServiceCall call, $0.AcceptRequestToJoinGameRequest request);
}
