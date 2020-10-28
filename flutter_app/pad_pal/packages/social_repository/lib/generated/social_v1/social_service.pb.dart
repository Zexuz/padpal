///
//  Generated code. Do not modify.
//  source: social_v1/social_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../common_v1/models.pb.dart' as $1;

import 'social_service.pbenum.dart';

export 'social_service.pbenum.dart';

class ChatMessageReceived extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ChatMessageReceived', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..p<$core.int>(2, 'participants', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  ChatMessageReceived._() : super();
  factory ChatMessageReceived() => create();
  factory ChatMessageReceived.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatMessageReceived.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ChatMessageReceived clone() => ChatMessageReceived()..mergeFromMessage(this);
  ChatMessageReceived copyWith(void Function(ChatMessageReceived) updates) => super.copyWith((message) => updates(message as ChatMessageReceived));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChatMessageReceived create() => ChatMessageReceived._();
  ChatMessageReceived createEmptyInstance() => create();
  static $pb.PbList<ChatMessageReceived> createRepeated() => $pb.PbList<ChatMessageReceived>();
  @$core.pragma('dart2js:noInline')
  static ChatMessageReceived getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatMessageReceived>(create);
  static ChatMessageReceived _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get participants => $_getList(1);
}

class FriendRequestReceived extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FriendRequestReceived', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'toUser', $pb.PbFieldType.O3, protoName: 'toUser')
    ..aOM<$1.User>(2, 'fromUser', protoName: 'fromUser', subBuilder: $1.User.create)
    ..hasRequiredFields = false
  ;

  FriendRequestReceived._() : super();
  factory FriendRequestReceived() => create();
  factory FriendRequestReceived.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendRequestReceived.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FriendRequestReceived clone() => FriendRequestReceived()..mergeFromMessage(this);
  FriendRequestReceived copyWith(void Function(FriendRequestReceived) updates) => super.copyWith((message) => updates(message as FriendRequestReceived));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FriendRequestReceived create() => FriendRequestReceived._();
  FriendRequestReceived createEmptyInstance() => create();
  static $pb.PbList<FriendRequestReceived> createRepeated() => $pb.PbList<FriendRequestReceived>();
  @$core.pragma('dart2js:noInline')
  static FriendRequestReceived getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendRequestReceived>(create);
  static FriendRequestReceived _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get toUser => $_getIZ(0);
  @$pb.TagNumber(1)
  set toUser($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearToUser() => clearField(1);

  @$pb.TagNumber(2)
  $1.User get fromUser => $_getN(1);
  @$pb.TagNumber(2)
  set fromUser($1.User v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromUser() => clearField(2);
  @$pb.TagNumber(2)
  $1.User ensureFromUser() => $_ensure(1);
}

class FriendRequestAccepted extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('FriendRequestAccepted', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOM<$1.User>(1, 'userThatAccepted', protoName: 'userThatAccepted', subBuilder: $1.User.create)
    ..a<$core.int>(2, 'userThatRequested', $pb.PbFieldType.O3, protoName: 'userThatRequested')
    ..hasRequiredFields = false
  ;

  FriendRequestAccepted._() : super();
  factory FriendRequestAccepted() => create();
  factory FriendRequestAccepted.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FriendRequestAccepted.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  FriendRequestAccepted clone() => FriendRequestAccepted()..mergeFromMessage(this);
  FriendRequestAccepted copyWith(void Function(FriendRequestAccepted) updates) => super.copyWith((message) => updates(message as FriendRequestAccepted));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FriendRequestAccepted create() => FriendRequestAccepted._();
  FriendRequestAccepted createEmptyInstance() => create();
  static $pb.PbList<FriendRequestAccepted> createRepeated() => $pb.PbList<FriendRequestAccepted>();
  @$core.pragma('dart2js:noInline')
  static FriendRequestAccepted getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FriendRequestAccepted>(create);
  static FriendRequestAccepted _defaultInstance;

  @$pb.TagNumber(1)
  $1.User get userThatAccepted => $_getN(0);
  @$pb.TagNumber(1)
  set userThatAccepted($1.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserThatAccepted() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserThatAccepted() => clearField(1);
  @$pb.TagNumber(1)
  $1.User ensureUserThatAccepted() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get userThatRequested => $_getIZ(1);
  @$pb.TagNumber(2)
  set userThatRequested($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserThatRequested() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserThatRequested() => clearField(2);
}

class UpdateLastSeenInRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UpdateLastSeenInRoomRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..hasRequiredFields = false
  ;

  UpdateLastSeenInRoomRequest._() : super();
  factory UpdateLastSeenInRoomRequest() => create();
  factory UpdateLastSeenInRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLastSeenInRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UpdateLastSeenInRoomRequest clone() => UpdateLastSeenInRoomRequest()..mergeFromMessage(this);
  UpdateLastSeenInRoomRequest copyWith(void Function(UpdateLastSeenInRoomRequest) updates) => super.copyWith((message) => updates(message as UpdateLastSeenInRoomRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateLastSeenInRoomRequest create() => UpdateLastSeenInRoomRequest._();
  UpdateLastSeenInRoomRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateLastSeenInRoomRequest> createRepeated() => $pb.PbList<UpdateLastSeenInRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateLastSeenInRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLastSeenInRoomRequest>(create);
  static UpdateLastSeenInRoomRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

class UpdateLastSeenInRoomResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UpdateLastSeenInRoomResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UpdateLastSeenInRoomResponse._() : super();
  factory UpdateLastSeenInRoomResponse() => create();
  factory UpdateLastSeenInRoomResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLastSeenInRoomResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UpdateLastSeenInRoomResponse clone() => UpdateLastSeenInRoomResponse()..mergeFromMessage(this);
  UpdateLastSeenInRoomResponse copyWith(void Function(UpdateLastSeenInRoomResponse) updates) => super.copyWith((message) => updates(message as UpdateLastSeenInRoomResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateLastSeenInRoomResponse create() => UpdateLastSeenInRoomResponse._();
  UpdateLastSeenInRoomResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateLastSeenInRoomResponse> createRepeated() => $pb.PbList<UpdateLastSeenInRoomResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateLastSeenInRoomResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLastSeenInRoomResponse>(create);
  static UpdateLastSeenInRoomResponse _defaultInstance;
}

class SubscribeToRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SubscribeToRoomRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..hasRequiredFields = false
  ;

  SubscribeToRoomRequest._() : super();
  factory SubscribeToRoomRequest() => create();
  factory SubscribeToRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeToRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SubscribeToRoomRequest clone() => SubscribeToRoomRequest()..mergeFromMessage(this);
  SubscribeToRoomRequest copyWith(void Function(SubscribeToRoomRequest) updates) => super.copyWith((message) => updates(message as SubscribeToRoomRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeToRoomRequest create() => SubscribeToRoomRequest._();
  SubscribeToRoomRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeToRoomRequest> createRepeated() => $pb.PbList<SubscribeToRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeToRoomRequest>(create);
  static SubscribeToRoomRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

enum SubscribeToRoomResponse_RoomEvent {
  newMessage, 
  notSet
}

class SubscribeToRoomResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SubscribeToRoomResponse_RoomEvent> _SubscribeToRoomResponse_RoomEventByTag = {
    1 : SubscribeToRoomResponse_RoomEvent.newMessage,
    0 : SubscribeToRoomResponse_RoomEvent.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SubscribeToRoomResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<Message>(1, 'newMessage', subBuilder: Message.create)
    ..hasRequiredFields = false
  ;

  SubscribeToRoomResponse._() : super();
  factory SubscribeToRoomResponse() => create();
  factory SubscribeToRoomResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeToRoomResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SubscribeToRoomResponse clone() => SubscribeToRoomResponse()..mergeFromMessage(this);
  SubscribeToRoomResponse copyWith(void Function(SubscribeToRoomResponse) updates) => super.copyWith((message) => updates(message as SubscribeToRoomResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeToRoomResponse create() => SubscribeToRoomResponse._();
  SubscribeToRoomResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeToRoomResponse> createRepeated() => $pb.PbList<SubscribeToRoomResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToRoomResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeToRoomResponse>(create);
  static SubscribeToRoomResponse _defaultInstance;

  SubscribeToRoomResponse_RoomEvent whichRoomEvent() => _SubscribeToRoomResponse_RoomEventByTag[$_whichOneof(0)];
  void clearRoomEvent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Message get newMessage => $_getN(0);
  @$pb.TagNumber(1)
  set newMessage(Message v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNewMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewMessage() => clearField(1);
  @$pb.TagNumber(1)
  Message ensureNewMessage() => $_ensure(0);
}

class GetProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetProfileRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..hasRequiredFields = false
  ;

  GetProfileRequest._() : super();
  factory GetProfileRequest() => create();
  factory GetProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetProfileRequest clone() => GetProfileRequest()..mergeFromMessage(this);
  GetProfileRequest copyWith(void Function(GetProfileRequest) updates) => super.copyWith((message) => updates(message as GetProfileRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProfileRequest create() => GetProfileRequest._();
  GetProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetProfileRequest> createRepeated() => $pb.PbList<GetProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProfileRequest>(create);
  static GetProfileRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetProfileResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOM<Profile>(1, 'profile', subBuilder: Profile.create)
    ..hasRequiredFields = false
  ;

  GetProfileResponse._() : super();
  factory GetProfileResponse() => create();
  factory GetProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetProfileResponse clone() => GetProfileResponse()..mergeFromMessage(this);
  GetProfileResponse copyWith(void Function(GetProfileResponse) updates) => super.copyWith((message) => updates(message as GetProfileResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProfileResponse create() => GetProfileResponse._();
  GetProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetProfileResponse> createRepeated() => $pb.PbList<GetProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProfileResponse>(create);
  static GetProfileResponse _defaultInstance;

  @$pb.TagNumber(1)
  Profile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(Profile v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => clearField(1);
  @$pb.TagNumber(1)
  Profile ensureProfile() => $_ensure(0);
}

class ChangeProfilePictureRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ChangeProfilePictureRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, 'imgData', $pb.PbFieldType.OY, protoName: 'imgData')
    ..hasRequiredFields = false
  ;

  ChangeProfilePictureRequest._() : super();
  factory ChangeProfilePictureRequest() => create();
  factory ChangeProfilePictureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeProfilePictureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ChangeProfilePictureRequest clone() => ChangeProfilePictureRequest()..mergeFromMessage(this);
  ChangeProfilePictureRequest copyWith(void Function(ChangeProfilePictureRequest) updates) => super.copyWith((message) => updates(message as ChangeProfilePictureRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangeProfilePictureRequest create() => ChangeProfilePictureRequest._();
  ChangeProfilePictureRequest createEmptyInstance() => create();
  static $pb.PbList<ChangeProfilePictureRequest> createRepeated() => $pb.PbList<ChangeProfilePictureRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangeProfilePictureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeProfilePictureRequest>(create);
  static ChangeProfilePictureRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get imgData => $_getN(0);
  @$pb.TagNumber(1)
  set imgData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasImgData() => $_has(0);
  @$pb.TagNumber(1)
  void clearImgData() => clearField(1);
}

class ChangeProfilePictureResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ChangeProfilePictureResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'url')
    ..hasRequiredFields = false
  ;

  ChangeProfilePictureResponse._() : super();
  factory ChangeProfilePictureResponse() => create();
  factory ChangeProfilePictureResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeProfilePictureResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ChangeProfilePictureResponse clone() => ChangeProfilePictureResponse()..mergeFromMessage(this);
  ChangeProfilePictureResponse copyWith(void Function(ChangeProfilePictureResponse) updates) => super.copyWith((message) => updates(message as ChangeProfilePictureResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangeProfilePictureResponse create() => ChangeProfilePictureResponse._();
  ChangeProfilePictureResponse createEmptyInstance() => create();
  static $pb.PbList<ChangeProfilePictureResponse> createRepeated() => $pb.PbList<ChangeProfilePictureResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangeProfilePictureResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeProfilePictureResponse>(create);
  static ChangeProfilePictureResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);
}

class MyProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MyProfileRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MyProfileRequest._() : super();
  factory MyProfileRequest() => create();
  factory MyProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MyProfileRequest clone() => MyProfileRequest()..mergeFromMessage(this);
  MyProfileRequest copyWith(void Function(MyProfileRequest) updates) => super.copyWith((message) => updates(message as MyProfileRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyProfileRequest create() => MyProfileRequest._();
  MyProfileRequest createEmptyInstance() => create();
  static $pb.PbList<MyProfileRequest> createRepeated() => $pb.PbList<MyProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static MyProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyProfileRequest>(create);
  static MyProfileRequest _defaultInstance;
}

class MyProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MyProfileResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOM<Profile>(1, 'me', subBuilder: Profile.create)
    ..hasRequiredFields = false
  ;

  MyProfileResponse._() : super();
  factory MyProfileResponse() => create();
  factory MyProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MyProfileResponse clone() => MyProfileResponse()..mergeFromMessage(this);
  MyProfileResponse copyWith(void Function(MyProfileResponse) updates) => super.copyWith((message) => updates(message as MyProfileResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyProfileResponse create() => MyProfileResponse._();
  MyProfileResponse createEmptyInstance() => create();
  static $pb.PbList<MyProfileResponse> createRepeated() => $pb.PbList<MyProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static MyProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyProfileResponse>(create);
  static MyProfileResponse _defaultInstance;

  @$pb.TagNumber(1)
  Profile get me => $_getN(0);
  @$pb.TagNumber(1)
  set me(Profile v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMe() => $_has(0);
  @$pb.TagNumber(1)
  void clearMe() => clearField(1);
  @$pb.TagNumber(1)
  Profile ensureMe() => $_ensure(0);
}

class RespondToFriendRequestRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RespondToFriendRequestRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..e<RespondToFriendRequestRequest_Action>(2, 'action', $pb.PbFieldType.OE, defaultOrMaker: RespondToFriendRequestRequest_Action.UNKNOWN, valueOf: RespondToFriendRequestRequest_Action.valueOf, enumValues: RespondToFriendRequestRequest_Action.values)
    ..hasRequiredFields = false
  ;

  RespondToFriendRequestRequest._() : super();
  factory RespondToFriendRequestRequest() => create();
  factory RespondToFriendRequestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RespondToFriendRequestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RespondToFriendRequestRequest clone() => RespondToFriendRequestRequest()..mergeFromMessage(this);
  RespondToFriendRequestRequest copyWith(void Function(RespondToFriendRequestRequest) updates) => super.copyWith((message) => updates(message as RespondToFriendRequestRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RespondToFriendRequestRequest create() => RespondToFriendRequestRequest._();
  RespondToFriendRequestRequest createEmptyInstance() => create();
  static $pb.PbList<RespondToFriendRequestRequest> createRepeated() => $pb.PbList<RespondToFriendRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static RespondToFriendRequestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RespondToFriendRequestRequest>(create);
  static RespondToFriendRequestRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  RespondToFriendRequestRequest_Action get action => $_getN(1);
  @$pb.TagNumber(2)
  set action(RespondToFriendRequestRequest_Action v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => clearField(2);
}

class RespondToFriendRequestResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RespondToFriendRequestResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RespondToFriendRequestResponse._() : super();
  factory RespondToFriendRequestResponse() => create();
  factory RespondToFriendRequestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RespondToFriendRequestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RespondToFriendRequestResponse clone() => RespondToFriendRequestResponse()..mergeFromMessage(this);
  RespondToFriendRequestResponse copyWith(void Function(RespondToFriendRequestResponse) updates) => super.copyWith((message) => updates(message as RespondToFriendRequestResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RespondToFriendRequestResponse create() => RespondToFriendRequestResponse._();
  RespondToFriendRequestResponse createEmptyInstance() => create();
  static $pb.PbList<RespondToFriendRequestResponse> createRepeated() => $pb.PbList<RespondToFriendRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static RespondToFriendRequestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RespondToFriendRequestResponse>(create);
  static RespondToFriendRequestResponse _defaultInstance;
}

class SendFriendRequestRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SendFriendRequestRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..hasRequiredFields = false
  ;

  SendFriendRequestRequest._() : super();
  factory SendFriendRequestRequest() => create();
  factory SendFriendRequestRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendFriendRequestRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SendFriendRequestRequest clone() => SendFriendRequestRequest()..mergeFromMessage(this);
  SendFriendRequestRequest copyWith(void Function(SendFriendRequestRequest) updates) => super.copyWith((message) => updates(message as SendFriendRequestRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendFriendRequestRequest create() => SendFriendRequestRequest._();
  SendFriendRequestRequest createEmptyInstance() => create();
  static $pb.PbList<SendFriendRequestRequest> createRepeated() => $pb.PbList<SendFriendRequestRequest>();
  @$core.pragma('dart2js:noInline')
  static SendFriendRequestRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendFriendRequestRequest>(create);
  static SendFriendRequestRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class SendFriendRequestResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SendFriendRequestResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SendFriendRequestResponse._() : super();
  factory SendFriendRequestResponse() => create();
  factory SendFriendRequestResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendFriendRequestResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SendFriendRequestResponse clone() => SendFriendRequestResponse()..mergeFromMessage(this);
  SendFriendRequestResponse copyWith(void Function(SendFriendRequestResponse) updates) => super.copyWith((message) => updates(message as SendFriendRequestResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendFriendRequestResponse create() => SendFriendRequestResponse._();
  SendFriendRequestResponse createEmptyInstance() => create();
  static $pb.PbList<SendFriendRequestResponse> createRepeated() => $pb.PbList<SendFriendRequestResponse>();
  @$core.pragma('dart2js:noInline')
  static SendFriendRequestResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendFriendRequestResponse>(create);
  static SendFriendRequestResponse _defaultInstance;
}

class SearchForProfileRequest_SearchOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SearchForProfileRequest.SearchOptions', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOB(1, 'onlyMyFriends', protoName: 'onlyMyFriends')
    ..hasRequiredFields = false
  ;

  SearchForProfileRequest_SearchOptions._() : super();
  factory SearchForProfileRequest_SearchOptions() => create();
  factory SearchForProfileRequest_SearchOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchForProfileRequest_SearchOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SearchForProfileRequest_SearchOptions clone() => SearchForProfileRequest_SearchOptions()..mergeFromMessage(this);
  SearchForProfileRequest_SearchOptions copyWith(void Function(SearchForProfileRequest_SearchOptions) updates) => super.copyWith((message) => updates(message as SearchForProfileRequest_SearchOptions));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchForProfileRequest_SearchOptions create() => SearchForProfileRequest_SearchOptions._();
  SearchForProfileRequest_SearchOptions createEmptyInstance() => create();
  static $pb.PbList<SearchForProfileRequest_SearchOptions> createRepeated() => $pb.PbList<SearchForProfileRequest_SearchOptions>();
  @$core.pragma('dart2js:noInline')
  static SearchForProfileRequest_SearchOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchForProfileRequest_SearchOptions>(create);
  static SearchForProfileRequest_SearchOptions _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get onlyMyFriends => $_getBF(0);
  @$pb.TagNumber(1)
  set onlyMyFriends($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOnlyMyFriends() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnlyMyFriends() => clearField(1);
}

class SearchForProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SearchForProfileRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'searchTerm', protoName: 'searchTerm')
    ..aOM<SearchForProfileRequest_SearchOptions>(2, 'options', subBuilder: SearchForProfileRequest_SearchOptions.create)
    ..hasRequiredFields = false
  ;

  SearchForProfileRequest._() : super();
  factory SearchForProfileRequest() => create();
  factory SearchForProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchForProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SearchForProfileRequest clone() => SearchForProfileRequest()..mergeFromMessage(this);
  SearchForProfileRequest copyWith(void Function(SearchForProfileRequest) updates) => super.copyWith((message) => updates(message as SearchForProfileRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchForProfileRequest create() => SearchForProfileRequest._();
  SearchForProfileRequest createEmptyInstance() => create();
  static $pb.PbList<SearchForProfileRequest> createRepeated() => $pb.PbList<SearchForProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchForProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchForProfileRequest>(create);
  static SearchForProfileRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get searchTerm => $_getSZ(0);
  @$pb.TagNumber(1)
  set searchTerm($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSearchTerm() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearchTerm() => clearField(1);

  @$pb.TagNumber(2)
  SearchForProfileRequest_SearchOptions get options => $_getN(1);
  @$pb.TagNumber(2)
  set options(SearchForProfileRequest_SearchOptions v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOptions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptions() => clearField(2);
  @$pb.TagNumber(2)
  SearchForProfileRequest_SearchOptions ensureOptions() => $_ensure(1);
}

class SearchForProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SearchForProfileResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..pc<Profile>(1, 'profiles', $pb.PbFieldType.PM, subBuilder: Profile.create)
    ..hasRequiredFields = false
  ;

  SearchForProfileResponse._() : super();
  factory SearchForProfileResponse() => create();
  factory SearchForProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchForProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SearchForProfileResponse clone() => SearchForProfileResponse()..mergeFromMessage(this);
  SearchForProfileResponse copyWith(void Function(SearchForProfileResponse) updates) => super.copyWith((message) => updates(message as SearchForProfileResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchForProfileResponse create() => SearchForProfileResponse._();
  SearchForProfileResponse createEmptyInstance() => create();
  static $pb.PbList<SearchForProfileResponse> createRepeated() => $pb.PbList<SearchForProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchForProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchForProfileResponse>(create);
  static SearchForProfileResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Profile> get profiles => $_getList(0);
}

class Profile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Profile', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..aOS(2, 'name')
    ..aOS(3, 'imgUrl', protoName: 'imgUrl')
    ..p<$core.int>(4, 'friends', $pb.PbFieldType.P3)
    ..p<$core.int>(5, 'friendRequests', $pb.PbFieldType.P3, protoName: 'friendRequests')
    ..hasRequiredFields = false
  ;

  Profile._() : super();
  factory Profile() => create();
  factory Profile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Profile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Profile clone() => Profile()..mergeFromMessage(this);
  Profile copyWith(void Function(Profile) updates) => super.copyWith((message) => updates(message as Profile));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Profile create() => Profile._();
  Profile createEmptyInstance() => create();
  static $pb.PbList<Profile> createRepeated() => $pb.PbList<Profile>();
  @$core.pragma('dart2js:noInline')
  static Profile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Profile>(create);
  static Profile _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get imgUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set imgUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasImgUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearImgUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get friends => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.int> get friendRequests => $_getList(4);
}

class SendMessageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SendMessageRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..aOS(2, 'content')
    ..hasRequiredFields = false
  ;

  SendMessageRequest._() : super();
  factory SendMessageRequest() => create();
  factory SendMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) => super.copyWith((message) => updates(message as SendMessageRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() => $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);
}

class SendMessageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SendMessageResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SendMessageResponse._() : super();
  factory SendMessageResponse() => create();
  factory SendMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SendMessageResponse clone() => SendMessageResponse()..mergeFromMessage(this);
  SendMessageResponse copyWith(void Function(SendMessageResponse) updates) => super.copyWith((message) => updates(message as SendMessageResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse create() => SendMessageResponse._();
  SendMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendMessageResponse> createRepeated() => $pb.PbList<SendMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageResponse>(create);
  static SendMessageResponse _defaultInstance;
}

class CreateRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CreateRoomRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'content')
    ..p<$core.int>(2, 'participants', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  CreateRoomRequest._() : super();
  factory CreateRoomRequest() => create();
  factory CreateRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CreateRoomRequest clone() => CreateRoomRequest()..mergeFromMessage(this);
  CreateRoomRequest copyWith(void Function(CreateRoomRequest) updates) => super.copyWith((message) => updates(message as CreateRoomRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateRoomRequest create() => CreateRoomRequest._();
  CreateRoomRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRoomRequest> createRepeated() => $pb.PbList<CreateRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRoomRequest>(create);
  static CreateRoomRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get participants => $_getList(1);
}

class CreateRoomResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CreateRoomResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..hasRequiredFields = false
  ;

  CreateRoomResponse._() : super();
  factory CreateRoomResponse() => create();
  factory CreateRoomResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateRoomResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CreateRoomResponse clone() => CreateRoomResponse()..mergeFromMessage(this);
  CreateRoomResponse copyWith(void Function(CreateRoomResponse) updates) => super.copyWith((message) => updates(message as CreateRoomResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateRoomResponse create() => CreateRoomResponse._();
  CreateRoomResponse createEmptyInstance() => create();
  static $pb.PbList<CreateRoomResponse> createRepeated() => $pb.PbList<CreateRoomResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateRoomResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRoomResponse>(create);
  static CreateRoomResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

class GetRoomsWhereUserIsParticipatingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetRoomsWhereUserIsParticipatingRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetRoomsWhereUserIsParticipatingRequest._() : super();
  factory GetRoomsWhereUserIsParticipatingRequest() => create();
  factory GetRoomsWhereUserIsParticipatingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRoomsWhereUserIsParticipatingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetRoomsWhereUserIsParticipatingRequest clone() => GetRoomsWhereUserIsParticipatingRequest()..mergeFromMessage(this);
  GetRoomsWhereUserIsParticipatingRequest copyWith(void Function(GetRoomsWhereUserIsParticipatingRequest) updates) => super.copyWith((message) => updates(message as GetRoomsWhereUserIsParticipatingRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRoomsWhereUserIsParticipatingRequest create() => GetRoomsWhereUserIsParticipatingRequest._();
  GetRoomsWhereUserIsParticipatingRequest createEmptyInstance() => create();
  static $pb.PbList<GetRoomsWhereUserIsParticipatingRequest> createRepeated() => $pb.PbList<GetRoomsWhereUserIsParticipatingRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRoomsWhereUserIsParticipatingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRoomsWhereUserIsParticipatingRequest>(create);
  static GetRoomsWhereUserIsParticipatingRequest _defaultInstance;
}

class GetRoomsWhereUserIsParticipatingResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetRoomsWhereUserIsParticipatingResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..pPS(1, 'roomIds', protoName: 'roomIds')
    ..hasRequiredFields = false
  ;

  GetRoomsWhereUserIsParticipatingResponse._() : super();
  factory GetRoomsWhereUserIsParticipatingResponse() => create();
  factory GetRoomsWhereUserIsParticipatingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRoomsWhereUserIsParticipatingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetRoomsWhereUserIsParticipatingResponse clone() => GetRoomsWhereUserIsParticipatingResponse()..mergeFromMessage(this);
  GetRoomsWhereUserIsParticipatingResponse copyWith(void Function(GetRoomsWhereUserIsParticipatingResponse) updates) => super.copyWith((message) => updates(message as GetRoomsWhereUserIsParticipatingResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRoomsWhereUserIsParticipatingResponse create() => GetRoomsWhereUserIsParticipatingResponse._();
  GetRoomsWhereUserIsParticipatingResponse createEmptyInstance() => create();
  static $pb.PbList<GetRoomsWhereUserIsParticipatingResponse> createRepeated() => $pb.PbList<GetRoomsWhereUserIsParticipatingResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRoomsWhereUserIsParticipatingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRoomsWhereUserIsParticipatingResponse>(create);
  static GetRoomsWhereUserIsParticipatingResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get roomIds => $_getList(0);
}

class GetRoomRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetRoomRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'roomId', protoName: 'roomId')
    ..hasRequiredFields = false
  ;

  GetRoomRequest._() : super();
  factory GetRoomRequest() => create();
  factory GetRoomRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRoomRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetRoomRequest clone() => GetRoomRequest()..mergeFromMessage(this);
  GetRoomRequest copyWith(void Function(GetRoomRequest) updates) => super.copyWith((message) => updates(message as GetRoomRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRoomRequest create() => GetRoomRequest._();
  GetRoomRequest createEmptyInstance() => create();
  static $pb.PbList<GetRoomRequest> createRepeated() => $pb.PbList<GetRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRoomRequest>(create);
  static GetRoomRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => clearField(1);
}

class GetRoomResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetRoomResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOM<ChatRoom>(1, 'room', subBuilder: ChatRoom.create)
    ..hasRequiredFields = false
  ;

  GetRoomResponse._() : super();
  factory GetRoomResponse() => create();
  factory GetRoomResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRoomResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetRoomResponse clone() => GetRoomResponse()..mergeFromMessage(this);
  GetRoomResponse copyWith(void Function(GetRoomResponse) updates) => super.copyWith((message) => updates(message as GetRoomResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRoomResponse create() => GetRoomResponse._();
  GetRoomResponse createEmptyInstance() => create();
  static $pb.PbList<GetRoomResponse> createRepeated() => $pb.PbList<GetRoomResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRoomResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRoomResponse>(create);
  static GetRoomResponse _defaultInstance;

  @$pb.TagNumber(1)
  ChatRoom get room => $_getN(0);
  @$pb.TagNumber(1)
  set room(ChatRoom v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoom() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoom() => clearField(1);
  @$pb.TagNumber(1)
  ChatRoom ensureRoom() => $_ensure(0);
}

class ChatRoom extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ChatRoom', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..a<$core.int>(2, 'admin', $pb.PbFieldType.O3)
    ..pc<Participant>(3, 'participants', $pb.PbFieldType.PM, subBuilder: Participant.create)
    ..pc<Message>(4, 'messages', $pb.PbFieldType.PM, subBuilder: Message.create)
    ..aOS(5, 'gameId')
    ..hasRequiredFields = false
  ;

  ChatRoom._() : super();
  factory ChatRoom() => create();
  factory ChatRoom.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatRoom.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ChatRoom clone() => ChatRoom()..mergeFromMessage(this);
  ChatRoom copyWith(void Function(ChatRoom) updates) => super.copyWith((message) => updates(message as ChatRoom));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChatRoom create() => ChatRoom._();
  ChatRoom createEmptyInstance() => create();
  static $pb.PbList<ChatRoom> createRepeated() => $pb.PbList<ChatRoom>();
  @$core.pragma('dart2js:noInline')
  static ChatRoom getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatRoom>(create);
  static ChatRoom _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get admin => $_getIZ(1);
  @$pb.TagNumber(2)
  set admin($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdmin() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdmin() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Participant> get participants => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Message> get messages => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get gameId => $_getSZ(4);
  @$pb.TagNumber(5)
  set gameId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGameId() => $_has(4);
  @$pb.TagNumber(5)
  void clearGameId() => clearField(5);
}

class Participant extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Participant', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOM<$1.User>(1, 'user', subBuilder: $1.User.create)
    ..aInt64(2, 'lastSeenTimestamp')
    ..hasRequiredFields = false
  ;

  Participant._() : super();
  factory Participant() => create();
  factory Participant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Participant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Participant clone() => Participant()..mergeFromMessage(this);
  Participant copyWith(void Function(Participant) updates) => super.copyWith((message) => updates(message as Participant));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Participant create() => Participant._();
  Participant createEmptyInstance() => create();
  static $pb.PbList<Participant> createRepeated() => $pb.PbList<Participant>();
  @$core.pragma('dart2js:noInline')
  static Participant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Participant>(create);
  static Participant _defaultInstance;

  @$pb.TagNumber(1)
  $1.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($1.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  $1.User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lastSeenTimestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set lastSeenTimestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastSeenTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastSeenTimestamp() => clearField(2);
}

class GetMessagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetMessagesRequest', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aInt64(1, 'afterTimestamp', protoName: 'afterTimestamp')
    ..hasRequiredFields = false
  ;

  GetMessagesRequest._() : super();
  factory GetMessagesRequest() => create();
  factory GetMessagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMessagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetMessagesRequest clone() => GetMessagesRequest()..mergeFromMessage(this);
  GetMessagesRequest copyWith(void Function(GetMessagesRequest) updates) => super.copyWith((message) => updates(message as GetMessagesRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest create() => GetMessagesRequest._();
  GetMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMessagesRequest> createRepeated() => $pb.PbList<GetMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesRequest>(create);
  static GetMessagesRequest _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get afterTimestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set afterTimestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAfterTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearAfterTimestamp() => clearField(1);
}

class GetMessagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetMessagesResponse', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..pc<Message>(1, 'messages', $pb.PbFieldType.PM, subBuilder: Message.create)
    ..hasRequiredFields = false
  ;

  GetMessagesResponse._() : super();
  factory GetMessagesResponse() => create();
  factory GetMessagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMessagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetMessagesResponse clone() => GetMessagesResponse()..mergeFromMessage(this);
  GetMessagesResponse copyWith(void Function(GetMessagesResponse) updates) => super.copyWith((message) => updates(message as GetMessagesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse create() => GetMessagesResponse._();
  GetMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMessagesResponse> createRepeated() => $pb.PbList<GetMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMessagesResponse>(create);
  static GetMessagesResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Message> get messages => $_getList(0);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Message', package: const $pb.PackageName('social.v1'), createEmptyInstance: create)
    ..aOS(1, 'content')
    ..a<$core.int>(2, 'author', $pb.PbFieldType.O3)
    ..aInt64(3, 'utcTimestamp', protoName: 'utcTimestamp')
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message() => create();
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Message clone() => Message()..mergeFromMessage(this);
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get content => $_getSZ(0);
  @$pb.TagNumber(1)
  set content($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get author => $_getIZ(1);
  @$pb.TagNumber(2)
  set author($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get utcTimestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set utcTimestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUtcTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearUtcTimestamp() => clearField(3);
}

