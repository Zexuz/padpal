///
//  Generated code. Do not modify.
//  source: game_v1/game_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../common_v1/models.pb.dart' as $2;

import 'game_service.pbenum.dart';

export 'game_service.pbenum.dart';

class GameCreated extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GameCreated', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOM<PublicGameInfo>(1, 'publicGameInfo', protoName: 'publicGameInfo', subBuilder: PublicGameInfo.create)
    ..p<$core.int>(2, 'invitedPlayers', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  GameCreated._() : super();
  factory GameCreated() => create();
  factory GameCreated.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameCreated.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GameCreated clone() => GameCreated()..mergeFromMessage(this);
  GameCreated copyWith(void Function(GameCreated) updates) => super.copyWith((message) => updates(message as GameCreated));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GameCreated create() => GameCreated._();
  GameCreated createEmptyInstance() => create();
  static $pb.PbList<GameCreated> createRepeated() => $pb.PbList<GameCreated>();
  @$core.pragma('dart2js:noInline')
  static GameCreated getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameCreated>(create);
  static GameCreated _defaultInstance;

  @$pb.TagNumber(1)
  PublicGameInfo get publicGameInfo => $_getN(0);
  @$pb.TagNumber(1)
  set publicGameInfo(PublicGameInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPublicGameInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicGameInfo() => clearField(1);
  @$pb.TagNumber(1)
  PublicGameInfo ensurePublicGameInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get invitedPlayers => $_getList(1);
}

class UserRequestedToJoinGame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserRequestedToJoinGame', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOM<PublicGameInfo>(1, 'game', subBuilder: PublicGameInfo.create)
    ..aOM<$2.User>(2, 'user', subBuilder: $2.User.create)
    ..hasRequiredFields = false
  ;

  UserRequestedToJoinGame._() : super();
  factory UserRequestedToJoinGame() => create();
  factory UserRequestedToJoinGame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRequestedToJoinGame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserRequestedToJoinGame clone() => UserRequestedToJoinGame()..mergeFromMessage(this);
  UserRequestedToJoinGame copyWith(void Function(UserRequestedToJoinGame) updates) => super.copyWith((message) => updates(message as UserRequestedToJoinGame));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserRequestedToJoinGame create() => UserRequestedToJoinGame._();
  UserRequestedToJoinGame createEmptyInstance() => create();
  static $pb.PbList<UserRequestedToJoinGame> createRepeated() => $pb.PbList<UserRequestedToJoinGame>();
  @$core.pragma('dart2js:noInline')
  static UserRequestedToJoinGame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRequestedToJoinGame>(create);
  static UserRequestedToJoinGame _defaultInstance;

  @$pb.TagNumber(1)
  PublicGameInfo get game => $_getN(0);
  @$pb.TagNumber(1)
  set game(PublicGameInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearGame() => clearField(1);
  @$pb.TagNumber(1)
  PublicGameInfo ensureGame() => $_ensure(0);

  @$pb.TagNumber(2)
  $2.User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($2.User v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => clearField(2);
  @$pb.TagNumber(2)
  $2.User ensureUser() => $_ensure(1);
}

class AcceptedToGame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AcceptedToGame', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOM<PublicGameInfo>(1, 'game', subBuilder: PublicGameInfo.create)
    ..a<$core.int>(2, 'user', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AcceptedToGame._() : super();
  factory AcceptedToGame() => create();
  factory AcceptedToGame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptedToGame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AcceptedToGame clone() => AcceptedToGame()..mergeFromMessage(this);
  AcceptedToGame copyWith(void Function(AcceptedToGame) updates) => super.copyWith((message) => updates(message as AcceptedToGame));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptedToGame create() => AcceptedToGame._();
  AcceptedToGame createEmptyInstance() => create();
  static $pb.PbList<AcceptedToGame> createRepeated() => $pb.PbList<AcceptedToGame>();
  @$core.pragma('dart2js:noInline')
  static AcceptedToGame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptedToGame>(create);
  static AcceptedToGame _defaultInstance;

  @$pb.TagNumber(1)
  PublicGameInfo get game => $_getN(0);
  @$pb.TagNumber(1)
  set game(PublicGameInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearGame() => clearField(1);
  @$pb.TagNumber(1)
  PublicGameInfo ensureGame() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get user => $_getIZ(1);
  @$pb.TagNumber(2)
  set user($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => clearField(2);
}

class AcceptRequestToJoinGameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AcceptRequestToJoinGameRequest', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOS(1, 'gameId', protoName: 'gameId')
    ..a<$core.int>(2, 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..hasRequiredFields = false
  ;

  AcceptRequestToJoinGameRequest._() : super();
  factory AcceptRequestToJoinGameRequest() => create();
  factory AcceptRequestToJoinGameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptRequestToJoinGameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AcceptRequestToJoinGameRequest clone() => AcceptRequestToJoinGameRequest()..mergeFromMessage(this);
  AcceptRequestToJoinGameRequest copyWith(void Function(AcceptRequestToJoinGameRequest) updates) => super.copyWith((message) => updates(message as AcceptRequestToJoinGameRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptRequestToJoinGameRequest create() => AcceptRequestToJoinGameRequest._();
  AcceptRequestToJoinGameRequest createEmptyInstance() => create();
  static $pb.PbList<AcceptRequestToJoinGameRequest> createRepeated() => $pb.PbList<AcceptRequestToJoinGameRequest>();
  @$core.pragma('dart2js:noInline')
  static AcceptRequestToJoinGameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptRequestToJoinGameRequest>(create);
  static AcceptRequestToJoinGameRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get userId => $_getIZ(1);
  @$pb.TagNumber(2)
  set userId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class AcceptRequestToJoinGameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AcceptRequestToJoinGameResponse', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AcceptRequestToJoinGameResponse._() : super();
  factory AcceptRequestToJoinGameResponse() => create();
  factory AcceptRequestToJoinGameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptRequestToJoinGameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AcceptRequestToJoinGameResponse clone() => AcceptRequestToJoinGameResponse()..mergeFromMessage(this);
  AcceptRequestToJoinGameResponse copyWith(void Function(AcceptRequestToJoinGameResponse) updates) => super.copyWith((message) => updates(message as AcceptRequestToJoinGameResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AcceptRequestToJoinGameResponse create() => AcceptRequestToJoinGameResponse._();
  AcceptRequestToJoinGameResponse createEmptyInstance() => create();
  static $pb.PbList<AcceptRequestToJoinGameResponse> createRepeated() => $pb.PbList<AcceptRequestToJoinGameResponse>();
  @$core.pragma('dart2js:noInline')
  static AcceptRequestToJoinGameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptRequestToJoinGameResponse>(create);
  static AcceptRequestToJoinGameResponse _defaultInstance;
}

class RequestToJoinGameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RequestToJoinGameRequest', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  RequestToJoinGameRequest._() : super();
  factory RequestToJoinGameRequest() => create();
  factory RequestToJoinGameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestToJoinGameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RequestToJoinGameRequest clone() => RequestToJoinGameRequest()..mergeFromMessage(this);
  RequestToJoinGameRequest copyWith(void Function(RequestToJoinGameRequest) updates) => super.copyWith((message) => updates(message as RequestToJoinGameRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestToJoinGameRequest create() => RequestToJoinGameRequest._();
  RequestToJoinGameRequest createEmptyInstance() => create();
  static $pb.PbList<RequestToJoinGameRequest> createRepeated() => $pb.PbList<RequestToJoinGameRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestToJoinGameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestToJoinGameRequest>(create);
  static RequestToJoinGameRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class RequestToJoinGameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RequestToJoinGameResponse', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RequestToJoinGameResponse._() : super();
  factory RequestToJoinGameResponse() => create();
  factory RequestToJoinGameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestToJoinGameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RequestToJoinGameResponse clone() => RequestToJoinGameResponse()..mergeFromMessage(this);
  RequestToJoinGameResponse copyWith(void Function(RequestToJoinGameResponse) updates) => super.copyWith((message) => updates(message as RequestToJoinGameResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestToJoinGameResponse create() => RequestToJoinGameResponse._();
  RequestToJoinGameResponse createEmptyInstance() => create();
  static $pb.PbList<RequestToJoinGameResponse> createRepeated() => $pb.PbList<RequestToJoinGameResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestToJoinGameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestToJoinGameResponse>(create);
  static RequestToJoinGameResponse _defaultInstance;
}

class GameFilter_TimeOffset extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GameFilter.TimeOffset', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aInt64(1, 'start')
    ..aInt64(2, 'end')
    ..hasRequiredFields = false
  ;

  GameFilter_TimeOffset._() : super();
  factory GameFilter_TimeOffset() => create();
  factory GameFilter_TimeOffset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameFilter_TimeOffset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GameFilter_TimeOffset clone() => GameFilter_TimeOffset()..mergeFromMessage(this);
  GameFilter_TimeOffset copyWith(void Function(GameFilter_TimeOffset) updates) => super.copyWith((message) => updates(message as GameFilter_TimeOffset));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GameFilter_TimeOffset create() => GameFilter_TimeOffset._();
  GameFilter_TimeOffset createEmptyInstance() => create();
  static $pb.PbList<GameFilter_TimeOffset> createRepeated() => $pb.PbList<GameFilter_TimeOffset>();
  @$core.pragma('dart2js:noInline')
  static GameFilter_TimeOffset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameFilter_TimeOffset>(create);
  static GameFilter_TimeOffset _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get start => $_getI64(0);
  @$pb.TagNumber(1)
  set start($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get end => $_getI64(1);
  @$pb.TagNumber(2)
  set end($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
}

class GameFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GameFilter', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOM<Point>(1, 'center', subBuilder: Point.create)
    ..a<$core.int>(2, 'distance', $pb.PbFieldType.O3)
    ..aOM<GameFilter_TimeOffset>(3, 'timeOffset', protoName: 'timeOffset', subBuilder: GameFilter_TimeOffset.create)
    ..hasRequiredFields = false
  ;

  GameFilter._() : super();
  factory GameFilter() => create();
  factory GameFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GameFilter clone() => GameFilter()..mergeFromMessage(this);
  GameFilter copyWith(void Function(GameFilter) updates) => super.copyWith((message) => updates(message as GameFilter));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GameFilter create() => GameFilter._();
  GameFilter createEmptyInstance() => create();
  static $pb.PbList<GameFilter> createRepeated() => $pb.PbList<GameFilter>();
  @$core.pragma('dart2js:noInline')
  static GameFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameFilter>(create);
  static GameFilter _defaultInstance;

  @$pb.TagNumber(1)
  Point get center => $_getN(0);
  @$pb.TagNumber(1)
  set center(Point v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCenter() => $_has(0);
  @$pb.TagNumber(1)
  void clearCenter() => clearField(1);
  @$pb.TagNumber(1)
  Point ensureCenter() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get distance => $_getIZ(1);
  @$pb.TagNumber(2)
  set distance($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDistance() => $_has(1);
  @$pb.TagNumber(2)
  void clearDistance() => clearField(2);

  @$pb.TagNumber(3)
  GameFilter_TimeOffset get timeOffset => $_getN(2);
  @$pb.TagNumber(3)
  set timeOffset(GameFilter_TimeOffset v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimeOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeOffset() => clearField(3);
  @$pb.TagNumber(3)
  GameFilter_TimeOffset ensureTimeOffset() => $_ensure(2);
}

class FindGamesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FindGamesRequest', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOM<GameFilter>(1, 'filter', subBuilder: GameFilter.create)
    ..hasRequiredFields = false
  ;

  FindGamesRequest._() : super();
  factory FindGamesRequest() => create();
  factory FindGamesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FindGamesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FindGamesRequest clone() => FindGamesRequest()..mergeFromMessage(this);
  FindGamesRequest copyWith(void Function(FindGamesRequest) updates) => super.copyWith((message) => updates(message as FindGamesRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindGamesRequest create() => FindGamesRequest._();
  FindGamesRequest createEmptyInstance() => create();
  static $pb.PbList<FindGamesRequest> createRepeated() => $pb.PbList<FindGamesRequest>();
  @$core.pragma('dart2js:noInline')
  static FindGamesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindGamesRequest>(create);
  static FindGamesRequest _defaultInstance;

  @$pb.TagNumber(1)
  GameFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(GameFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  GameFilter ensureFilter() => $_ensure(0);
}

class FindGamesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FindGamesResponse', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..pc<PublicGameInfo>(1, 'games', $pb.PbFieldType.PM, subBuilder: PublicGameInfo.create)
    ..hasRequiredFields = false
  ;

  FindGamesResponse._() : super();
  factory FindGamesResponse() => create();
  factory FindGamesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FindGamesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FindGamesResponse clone() => FindGamesResponse()..mergeFromMessage(this);
  FindGamesResponse copyWith(void Function(FindGamesResponse) updates) => super.copyWith((message) => updates(message as FindGamesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindGamesResponse create() => FindGamesResponse._();
  FindGamesResponse createEmptyInstance() => create();
  static $pb.PbList<FindGamesResponse> createRepeated() => $pb.PbList<FindGamesResponse>();
  @$core.pragma('dart2js:noInline')
  static FindGamesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FindGamesResponse>(create);
  static FindGamesResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PublicGameInfo> get games => $_getList(0);
}

class PublicGameInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PublicGameInfo', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOM<PadelCenter>(2, 'location', subBuilder: PadelCenter.create)
    ..aInt64(3, 'startTime')
    ..a<$core.int>(4, 'durationInMinutes', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'pricePerPerson', $pb.PbFieldType.O3)
    ..e<CourtType>(6, 'courtType', $pb.PbFieldType.OE, defaultOrMaker: CourtType.UNKNOWN, valueOf: CourtType.valueOf, enumValues: CourtType.values)
    ..aOM<$2.User>(7, 'creator', subBuilder: $2.User.create)
    ..pc<$2.User>(8, 'playerRequestedToJoin', $pb.PbFieldType.PM, protoName: 'playerRequestedToJoin', subBuilder: $2.User.create)
    ..pc<$2.User>(9, 'players', $pb.PbFieldType.PM, subBuilder: $2.User.create)
    ..hasRequiredFields = false
  ;

  PublicGameInfo._() : super();
  factory PublicGameInfo() => create();
  factory PublicGameInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicGameInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PublicGameInfo clone() => PublicGameInfo()..mergeFromMessage(this);
  PublicGameInfo copyWith(void Function(PublicGameInfo) updates) => super.copyWith((message) => updates(message as PublicGameInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PublicGameInfo create() => PublicGameInfo._();
  PublicGameInfo createEmptyInstance() => create();
  static $pb.PbList<PublicGameInfo> createRepeated() => $pb.PbList<PublicGameInfo>();
  @$core.pragma('dart2js:noInline')
  static PublicGameInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicGameInfo>(create);
  static PublicGameInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  PadelCenter get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(PadelCenter v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => clearField(2);
  @$pb.TagNumber(2)
  PadelCenter ensureLocation() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get startTime => $_getI64(2);
  @$pb.TagNumber(3)
  set startTime($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartTime() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get durationInMinutes => $_getIZ(3);
  @$pb.TagNumber(4)
  set durationInMinutes($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDurationInMinutes() => $_has(3);
  @$pb.TagNumber(4)
  void clearDurationInMinutes() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pricePerPerson => $_getIZ(4);
  @$pb.TagNumber(5)
  set pricePerPerson($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPricePerPerson() => $_has(4);
  @$pb.TagNumber(5)
  void clearPricePerPerson() => clearField(5);

  @$pb.TagNumber(6)
  CourtType get courtType => $_getN(5);
  @$pb.TagNumber(6)
  set courtType(CourtType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCourtType() => $_has(5);
  @$pb.TagNumber(6)
  void clearCourtType() => clearField(6);

  @$pb.TagNumber(7)
  $2.User get creator => $_getN(6);
  @$pb.TagNumber(7)
  set creator($2.User v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreator() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreator() => clearField(7);
  @$pb.TagNumber(7)
  $2.User ensureCreator() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.List<$2.User> get playerRequestedToJoin => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<$2.User> get players => $_getList(8);
}

class PrivateGameInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PrivateGameInfo', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOS(1, 'courtName', protoName: 'courtName')
    ..aOS(2, 'additionalInformation')
    ..hasRequiredFields = false
  ;

  PrivateGameInfo._() : super();
  factory PrivateGameInfo() => create();
  factory PrivateGameInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrivateGameInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PrivateGameInfo clone() => PrivateGameInfo()..mergeFromMessage(this);
  PrivateGameInfo copyWith(void Function(PrivateGameInfo) updates) => super.copyWith((message) => updates(message as PrivateGameInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PrivateGameInfo create() => PrivateGameInfo._();
  PrivateGameInfo createEmptyInstance() => create();
  static $pb.PbList<PrivateGameInfo> createRepeated() => $pb.PbList<PrivateGameInfo>();
  @$core.pragma('dart2js:noInline')
  static PrivateGameInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivateGameInfo>(create);
  static PrivateGameInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get courtName => $_getSZ(0);
  @$pb.TagNumber(1)
  set courtName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCourtName() => $_has(0);
  @$pb.TagNumber(1)
  void clearCourtName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get additionalInformation => $_getSZ(1);
  @$pb.TagNumber(2)
  set additionalInformation($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdditionalInformation() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdditionalInformation() => clearField(2);
}

class Point extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Point', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..a<$core.double>(1, 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Point._() : super();
  factory Point() => create();
  factory Point.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Point.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Point clone() => Point()..mergeFromMessage(this);
  Point copyWith(void Function(Point) updates) => super.copyWith((message) => updates(message as Point));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Point create() => Point._();
  Point createEmptyInstance() => create();
  static $pb.PbList<Point> createRepeated() => $pb.PbList<Point>();
  @$core.pragma('dart2js:noInline')
  static Point getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Point>(create);
  static Point _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

class PadelCenter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PadelCenter', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..aOM<Point>(2, 'point', subBuilder: Point.create)
    ..hasRequiredFields = false
  ;

  PadelCenter._() : super();
  factory PadelCenter() => create();
  factory PadelCenter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PadelCenter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PadelCenter clone() => PadelCenter()..mergeFromMessage(this);
  PadelCenter copyWith(void Function(PadelCenter) updates) => super.copyWith((message) => updates(message as PadelCenter));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PadelCenter create() => PadelCenter._();
  PadelCenter createEmptyInstance() => create();
  static $pb.PbList<PadelCenter> createRepeated() => $pb.PbList<PadelCenter>();
  @$core.pragma('dart2js:noInline')
  static PadelCenter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PadelCenter>(create);
  static PadelCenter _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  Point get point => $_getN(1);
  @$pb.TagNumber(2)
  set point(Point v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearPoint() => clearField(2);
  @$pb.TagNumber(2)
  Point ensurePoint() => $_ensure(1);
}

class CreateGameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CreateGameRequest', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOM<PadelCenter>(1, 'location', subBuilder: PadelCenter.create)
    ..aInt64(2, 'startTime')
    ..a<$core.int>(3, 'durationInMinutes', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'pricePerPerson', $pb.PbFieldType.O3)
    ..e<CourtType>(5, 'courtType', $pb.PbFieldType.OE, defaultOrMaker: CourtType.UNKNOWN, valueOf: CourtType.valueOf, enumValues: CourtType.values)
    ..aOM<$2.User>(6, 'Creator', protoName: 'Creator', subBuilder: $2.User.create)
    ..aOS(7, 'courtName', protoName: 'courtName')
    ..aOS(8, 'additionalInformation')
    ..p<$core.int>(9, 'playersToInvite', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  CreateGameRequest._() : super();
  factory CreateGameRequest() => create();
  factory CreateGameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CreateGameRequest clone() => CreateGameRequest()..mergeFromMessage(this);
  CreateGameRequest copyWith(void Function(CreateGameRequest) updates) => super.copyWith((message) => updates(message as CreateGameRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateGameRequest create() => CreateGameRequest._();
  CreateGameRequest createEmptyInstance() => create();
  static $pb.PbList<CreateGameRequest> createRepeated() => $pb.PbList<CreateGameRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateGameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateGameRequest>(create);
  static CreateGameRequest _defaultInstance;

  @$pb.TagNumber(1)
  PadelCenter get location => $_getN(0);
  @$pb.TagNumber(1)
  set location(PadelCenter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => clearField(1);
  @$pb.TagNumber(1)
  PadelCenter ensureLocation() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get startTime => $_getI64(1);
  @$pb.TagNumber(2)
  set startTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get durationInMinutes => $_getIZ(2);
  @$pb.TagNumber(3)
  set durationInMinutes($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDurationInMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearDurationInMinutes() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get pricePerPerson => $_getIZ(3);
  @$pb.TagNumber(4)
  set pricePerPerson($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPricePerPerson() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerPerson() => clearField(4);

  @$pb.TagNumber(5)
  CourtType get courtType => $_getN(4);
  @$pb.TagNumber(5)
  set courtType(CourtType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCourtType() => $_has(4);
  @$pb.TagNumber(5)
  void clearCourtType() => clearField(5);

  @$pb.TagNumber(6)
  $2.User get creator => $_getN(5);
  @$pb.TagNumber(6)
  set creator($2.User v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreator() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreator() => clearField(6);
  @$pb.TagNumber(6)
  $2.User ensureCreator() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get courtName => $_getSZ(6);
  @$pb.TagNumber(7)
  set courtName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCourtName() => $_has(6);
  @$pb.TagNumber(7)
  void clearCourtName() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get additionalInformation => $_getSZ(7);
  @$pb.TagNumber(8)
  set additionalInformation($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAdditionalInformation() => $_has(7);
  @$pb.TagNumber(8)
  void clearAdditionalInformation() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.int> get playersToInvite => $_getList(8);
}

class CreateGameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CreateGameResponse', package: const $pb.PackageName('game.v1'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  CreateGameResponse._() : super();
  factory CreateGameResponse() => create();
  factory CreateGameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateGameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CreateGameResponse clone() => CreateGameResponse()..mergeFromMessage(this);
  CreateGameResponse copyWith(void Function(CreateGameResponse) updates) => super.copyWith((message) => updates(message as CreateGameResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateGameResponse create() => CreateGameResponse._();
  CreateGameResponse createEmptyInstance() => create();
  static $pb.PbList<CreateGameResponse> createRepeated() => $pb.PbList<CreateGameResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateGameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateGameResponse>(create);
  static CreateGameResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

