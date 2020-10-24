///
//  Generated code. Do not modify.
//  source: notification_v1/notification_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../common_v1/models.pb.dart' as $2;
import '../game_v1/game_service.pb.dart' as $0;

class PushNotification_ChatMessageReceived extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushNotification.ChatMessageReceived', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..hasRequiredFields = false
  ;

  PushNotification_ChatMessageReceived._() : super();
  factory PushNotification_ChatMessageReceived() => create();
  factory PushNotification_ChatMessageReceived.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushNotification_ChatMessageReceived.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushNotification_ChatMessageReceived clone() => PushNotification_ChatMessageReceived()..mergeFromMessage(this);
  PushNotification_ChatMessageReceived copyWith(void Function(PushNotification_ChatMessageReceived) updates) => super.copyWith((message) => updates(message as PushNotification_ChatMessageReceived));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushNotification_ChatMessageReceived create() => PushNotification_ChatMessageReceived._();
  PushNotification_ChatMessageReceived createEmptyInstance() => create();
  static $pb.PbList<PushNotification_ChatMessageReceived> createRepeated() => $pb.PbList<PushNotification_ChatMessageReceived>();
  @$core.pragma('dart2js:noInline')
  static PushNotification_ChatMessageReceived getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotification_ChatMessageReceived>(create);
  static PushNotification_ChatMessageReceived _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

class PushNotification_FriendRequestReceived extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushNotification.FriendRequestReceived', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..aOM<$2.User>(1, 'player', subBuilder: $2.User.create)
    ..hasRequiredFields = false
  ;

  PushNotification_FriendRequestReceived._() : super();
  factory PushNotification_FriendRequestReceived() => create();
  factory PushNotification_FriendRequestReceived.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushNotification_FriendRequestReceived.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushNotification_FriendRequestReceived clone() => PushNotification_FriendRequestReceived()..mergeFromMessage(this);
  PushNotification_FriendRequestReceived copyWith(void Function(PushNotification_FriendRequestReceived) updates) => super.copyWith((message) => updates(message as PushNotification_FriendRequestReceived));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushNotification_FriendRequestReceived create() => PushNotification_FriendRequestReceived._();
  PushNotification_FriendRequestReceived createEmptyInstance() => create();
  static $pb.PbList<PushNotification_FriendRequestReceived> createRepeated() => $pb.PbList<PushNotification_FriendRequestReceived>();
  @$core.pragma('dart2js:noInline')
  static PushNotification_FriendRequestReceived getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotification_FriendRequestReceived>(create);
  static PushNotification_FriendRequestReceived _defaultInstance;

  @$pb.TagNumber(1)
  $2.User get player => $_getN(0);
  @$pb.TagNumber(1)
  set player($2.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => clearField(1);
  @$pb.TagNumber(1)
  $2.User ensurePlayer() => $_ensure(0);
}

class PushNotification_FriendRequestAccepted extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushNotification.FriendRequestAccepted', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..aOM<$2.User>(1, 'player', subBuilder: $2.User.create)
    ..hasRequiredFields = false
  ;

  PushNotification_FriendRequestAccepted._() : super();
  factory PushNotification_FriendRequestAccepted() => create();
  factory PushNotification_FriendRequestAccepted.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushNotification_FriendRequestAccepted.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushNotification_FriendRequestAccepted clone() => PushNotification_FriendRequestAccepted()..mergeFromMessage(this);
  PushNotification_FriendRequestAccepted copyWith(void Function(PushNotification_FriendRequestAccepted) updates) => super.copyWith((message) => updates(message as PushNotification_FriendRequestAccepted));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushNotification_FriendRequestAccepted create() => PushNotification_FriendRequestAccepted._();
  PushNotification_FriendRequestAccepted createEmptyInstance() => create();
  static $pb.PbList<PushNotification_FriendRequestAccepted> createRepeated() => $pb.PbList<PushNotification_FriendRequestAccepted>();
  @$core.pragma('dart2js:noInline')
  static PushNotification_FriendRequestAccepted getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotification_FriendRequestAccepted>(create);
  static PushNotification_FriendRequestAccepted _defaultInstance;

  @$pb.TagNumber(1)
  $2.User get player => $_getN(0);
  @$pb.TagNumber(1)
  set player($2.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => clearField(1);
  @$pb.TagNumber(1)
  $2.User ensurePlayer() => $_ensure(0);
}

class PushNotification_InvitedToGame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushNotification.InvitedToGame', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..aOM<$0.PublicGameInfo>(1, 'GameInfo', protoName: 'GameInfo', subBuilder: $0.PublicGameInfo.create)
    ..hasRequiredFields = false
  ;

  PushNotification_InvitedToGame._() : super();
  factory PushNotification_InvitedToGame() => create();
  factory PushNotification_InvitedToGame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushNotification_InvitedToGame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushNotification_InvitedToGame clone() => PushNotification_InvitedToGame()..mergeFromMessage(this);
  PushNotification_InvitedToGame copyWith(void Function(PushNotification_InvitedToGame) updates) => super.copyWith((message) => updates(message as PushNotification_InvitedToGame));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushNotification_InvitedToGame create() => PushNotification_InvitedToGame._();
  PushNotification_InvitedToGame createEmptyInstance() => create();
  static $pb.PbList<PushNotification_InvitedToGame> createRepeated() => $pb.PbList<PushNotification_InvitedToGame>();
  @$core.pragma('dart2js:noInline')
  static PushNotification_InvitedToGame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotification_InvitedToGame>(create);
  static PushNotification_InvitedToGame _defaultInstance;

  @$pb.TagNumber(1)
  $0.PublicGameInfo get gameInfo => $_getN(0);
  @$pb.TagNumber(1)
  set gameInfo($0.PublicGameInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameInfo() => clearField(1);
  @$pb.TagNumber(1)
  $0.PublicGameInfo ensureGameInfo() => $_ensure(0);
}

class PushNotification_RequestedToJoinGame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushNotification.RequestedToJoinGame', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..aOS(1, 'gameId', protoName: 'gameId')
    ..aOM<$2.User>(2, 'user', subBuilder: $2.User.create)
    ..hasRequiredFields = false
  ;

  PushNotification_RequestedToJoinGame._() : super();
  factory PushNotification_RequestedToJoinGame() => create();
  factory PushNotification_RequestedToJoinGame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushNotification_RequestedToJoinGame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushNotification_RequestedToJoinGame clone() => PushNotification_RequestedToJoinGame()..mergeFromMessage(this);
  PushNotification_RequestedToJoinGame copyWith(void Function(PushNotification_RequestedToJoinGame) updates) => super.copyWith((message) => updates(message as PushNotification_RequestedToJoinGame));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushNotification_RequestedToJoinGame create() => PushNotification_RequestedToJoinGame._();
  PushNotification_RequestedToJoinGame createEmptyInstance() => create();
  static $pb.PbList<PushNotification_RequestedToJoinGame> createRepeated() => $pb.PbList<PushNotification_RequestedToJoinGame>();
  @$core.pragma('dart2js:noInline')
  static PushNotification_RequestedToJoinGame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotification_RequestedToJoinGame>(create);
  static PushNotification_RequestedToJoinGame _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameId() => clearField(1);

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

enum PushNotification_Notification {
  chatMessageReceived, 
  friendRequestReceived, 
  friendRequestAccepted, 
  invitedToGame, 
  requestedToJoinGame, 
  notSet
}

class PushNotification extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, PushNotification_Notification> _PushNotification_NotificationByTag = {
    10 : PushNotification_Notification.chatMessageReceived,
    11 : PushNotification_Notification.friendRequestReceived,
    12 : PushNotification_Notification.friendRequestAccepted,
    13 : PushNotification_Notification.invitedToGame,
    14 : PushNotification_Notification.requestedToJoinGame,
    0 : PushNotification_Notification.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushNotification', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..oo(0, [10, 11, 12, 13, 14])
    ..aInt64(1, 'utcTimestamp', protoName: 'utcTimestamp')
    ..aOM<PushNotification_ChatMessageReceived>(10, 'chatMessageReceived', protoName: 'chatMessageReceived', subBuilder: PushNotification_ChatMessageReceived.create)
    ..aOM<PushNotification_FriendRequestReceived>(11, 'friendRequestReceived', protoName: 'friendRequestReceived', subBuilder: PushNotification_FriendRequestReceived.create)
    ..aOM<PushNotification_FriendRequestAccepted>(12, 'friendRequestAccepted', protoName: 'friendRequestAccepted', subBuilder: PushNotification_FriendRequestAccepted.create)
    ..aOM<PushNotification_InvitedToGame>(13, 'invitedToGame', protoName: 'invitedToGame', subBuilder: PushNotification_InvitedToGame.create)
    ..aOM<PushNotification_RequestedToJoinGame>(14, 'requestedToJoinGame', subBuilder: PushNotification_RequestedToJoinGame.create)
    ..hasRequiredFields = false
  ;

  PushNotification._() : super();
  factory PushNotification() => create();
  factory PushNotification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PushNotification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PushNotification clone() => PushNotification()..mergeFromMessage(this);
  PushNotification copyWith(void Function(PushNotification) updates) => super.copyWith((message) => updates(message as PushNotification));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PushNotification create() => PushNotification._();
  PushNotification createEmptyInstance() => create();
  static $pb.PbList<PushNotification> createRepeated() => $pb.PbList<PushNotification>();
  @$core.pragma('dart2js:noInline')
  static PushNotification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PushNotification>(create);
  static PushNotification _defaultInstance;

  PushNotification_Notification whichNotification() => _PushNotification_NotificationByTag[$_whichOneof(0)];
  void clearNotification() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get utcTimestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set utcTimestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUtcTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtcTimestamp() => clearField(1);

  @$pb.TagNumber(10)
  PushNotification_ChatMessageReceived get chatMessageReceived => $_getN(1);
  @$pb.TagNumber(10)
  set chatMessageReceived(PushNotification_ChatMessageReceived v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasChatMessageReceived() => $_has(1);
  @$pb.TagNumber(10)
  void clearChatMessageReceived() => clearField(10);
  @$pb.TagNumber(10)
  PushNotification_ChatMessageReceived ensureChatMessageReceived() => $_ensure(1);

  @$pb.TagNumber(11)
  PushNotification_FriendRequestReceived get friendRequestReceived => $_getN(2);
  @$pb.TagNumber(11)
  set friendRequestReceived(PushNotification_FriendRequestReceived v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasFriendRequestReceived() => $_has(2);
  @$pb.TagNumber(11)
  void clearFriendRequestReceived() => clearField(11);
  @$pb.TagNumber(11)
  PushNotification_FriendRequestReceived ensureFriendRequestReceived() => $_ensure(2);

  @$pb.TagNumber(12)
  PushNotification_FriendRequestAccepted get friendRequestAccepted => $_getN(3);
  @$pb.TagNumber(12)
  set friendRequestAccepted(PushNotification_FriendRequestAccepted v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasFriendRequestAccepted() => $_has(3);
  @$pb.TagNumber(12)
  void clearFriendRequestAccepted() => clearField(12);
  @$pb.TagNumber(12)
  PushNotification_FriendRequestAccepted ensureFriendRequestAccepted() => $_ensure(3);

  @$pb.TagNumber(13)
  PushNotification_InvitedToGame get invitedToGame => $_getN(4);
  @$pb.TagNumber(13)
  set invitedToGame(PushNotification_InvitedToGame v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasInvitedToGame() => $_has(4);
  @$pb.TagNumber(13)
  void clearInvitedToGame() => clearField(13);
  @$pb.TagNumber(13)
  PushNotification_InvitedToGame ensureInvitedToGame() => $_ensure(4);

  @$pb.TagNumber(14)
  PushNotification_RequestedToJoinGame get requestedToJoinGame => $_getN(5);
  @$pb.TagNumber(14)
  set requestedToJoinGame(PushNotification_RequestedToJoinGame v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasRequestedToJoinGame() => $_has(5);
  @$pb.TagNumber(14)
  void clearRequestedToJoinGame() => clearField(14);
  @$pb.TagNumber(14)
  PushNotification_RequestedToJoinGame ensureRequestedToJoinGame() => $_ensure(5);
}

class RemoveNotificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RemoveNotificationRequest', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RemoveNotificationRequest._() : super();
  factory RemoveNotificationRequest() => create();
  factory RemoveNotificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveNotificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RemoveNotificationRequest clone() => RemoveNotificationRequest()..mergeFromMessage(this);
  RemoveNotificationRequest copyWith(void Function(RemoveNotificationRequest) updates) => super.copyWith((message) => updates(message as RemoveNotificationRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveNotificationRequest create() => RemoveNotificationRequest._();
  RemoveNotificationRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveNotificationRequest> createRepeated() => $pb.PbList<RemoveNotificationRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveNotificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveNotificationRequest>(create);
  static RemoveNotificationRequest _defaultInstance;
}

class RemoveNotificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RemoveNotificationResponse', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RemoveNotificationResponse._() : super();
  factory RemoveNotificationResponse() => create();
  factory RemoveNotificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveNotificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RemoveNotificationResponse clone() => RemoveNotificationResponse()..mergeFromMessage(this);
  RemoveNotificationResponse copyWith(void Function(RemoveNotificationResponse) updates) => super.copyWith((message) => updates(message as RemoveNotificationResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveNotificationResponse create() => RemoveNotificationResponse._();
  RemoveNotificationResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveNotificationResponse> createRepeated() => $pb.PbList<RemoveNotificationResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveNotificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveNotificationResponse>(create);
  static RemoveNotificationResponse _defaultInstance;
}

class GetNotificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetNotificationRequest', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetNotificationRequest._() : super();
  factory GetNotificationRequest() => create();
  factory GetNotificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetNotificationRequest clone() => GetNotificationRequest()..mergeFromMessage(this);
  GetNotificationRequest copyWith(void Function(GetNotificationRequest) updates) => super.copyWith((message) => updates(message as GetNotificationRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetNotificationRequest create() => GetNotificationRequest._();
  GetNotificationRequest createEmptyInstance() => create();
  static $pb.PbList<GetNotificationRequest> createRepeated() => $pb.PbList<GetNotificationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNotificationRequest>(create);
  static GetNotificationRequest _defaultInstance;
}

class GetNotificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetNotificationResponse', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..pc<PushNotification>(1, 'notifications', $pb.PbFieldType.PM, subBuilder: PushNotification.create)
    ..hasRequiredFields = false
  ;

  GetNotificationResponse._() : super();
  factory GetNotificationResponse() => create();
  factory GetNotificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNotificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetNotificationResponse clone() => GetNotificationResponse()..mergeFromMessage(this);
  GetNotificationResponse copyWith(void Function(GetNotificationResponse) updates) => super.copyWith((message) => updates(message as GetNotificationResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetNotificationResponse create() => GetNotificationResponse._();
  GetNotificationResponse createEmptyInstance() => create();
  static $pb.PbList<GetNotificationResponse> createRepeated() => $pb.PbList<GetNotificationResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNotificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNotificationResponse>(create);
  static GetNotificationResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PushNotification> get notifications => $_getList(0);
}

class AppendFcmTokenToUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AppendFcmTokenToUserRequest', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..aOS(1, 'fcmToken', protoName: 'fcmToken')
    ..hasRequiredFields = false
  ;

  AppendFcmTokenToUserRequest._() : super();
  factory AppendFcmTokenToUserRequest() => create();
  factory AppendFcmTokenToUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppendFcmTokenToUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AppendFcmTokenToUserRequest clone() => AppendFcmTokenToUserRequest()..mergeFromMessage(this);
  AppendFcmTokenToUserRequest copyWith(void Function(AppendFcmTokenToUserRequest) updates) => super.copyWith((message) => updates(message as AppendFcmTokenToUserRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppendFcmTokenToUserRequest create() => AppendFcmTokenToUserRequest._();
  AppendFcmTokenToUserRequest createEmptyInstance() => create();
  static $pb.PbList<AppendFcmTokenToUserRequest> createRepeated() => $pb.PbList<AppendFcmTokenToUserRequest>();
  @$core.pragma('dart2js:noInline')
  static AppendFcmTokenToUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppendFcmTokenToUserRequest>(create);
  static AppendFcmTokenToUserRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fcmToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set fcmToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFcmToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearFcmToken() => clearField(1);
}

class AppendFcmTokenToUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AppendFcmTokenToUserResponse', package: const $pb.PackageName('notification.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AppendFcmTokenToUserResponse._() : super();
  factory AppendFcmTokenToUserResponse() => create();
  factory AppendFcmTokenToUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AppendFcmTokenToUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AppendFcmTokenToUserResponse clone() => AppendFcmTokenToUserResponse()..mergeFromMessage(this);
  AppendFcmTokenToUserResponse copyWith(void Function(AppendFcmTokenToUserResponse) updates) => super.copyWith((message) => updates(message as AppendFcmTokenToUserResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AppendFcmTokenToUserResponse create() => AppendFcmTokenToUserResponse._();
  AppendFcmTokenToUserResponse createEmptyInstance() => create();
  static $pb.PbList<AppendFcmTokenToUserResponse> createRepeated() => $pb.PbList<AppendFcmTokenToUserResponse>();
  @$core.pragma('dart2js:noInline')
  static AppendFcmTokenToUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AppendFcmTokenToUserResponse>(create);
  static AppendFcmTokenToUserResponse _defaultInstance;
}

