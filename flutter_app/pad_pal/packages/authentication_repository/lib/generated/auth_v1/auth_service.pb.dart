///
//  Generated code. Do not modify.
//  source: auth_v1/auth_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth_service.pbenum.dart';

export 'auth_service.pbenum.dart';

class UserSignUpMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserSignUpMessage', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'userId', $pb.PbFieldType.O3, protoName: 'userId')
    ..aOS(2, 'name')
    ..hasRequiredFields = false
  ;

  UserSignUpMessage._() : super();
  factory UserSignUpMessage() => create();
  factory UserSignUpMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserSignUpMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserSignUpMessage clone() => UserSignUpMessage()..mergeFromMessage(this);
  UserSignUpMessage copyWith(void Function(UserSignUpMessage) updates) => super.copyWith((message) => updates(message as UserSignUpMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserSignUpMessage create() => UserSignUpMessage._();
  UserSignUpMessage createEmptyInstance() => create();
  static $pb.PbList<UserSignUpMessage> createRepeated() => $pb.PbList<UserSignUpMessage>();
  @$core.pragma('dart2js:noInline')
  static UserSignUpMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserSignUpMessage>(create);
  static UserSignUpMessage _defaultInstance;

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
}

class SignInRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SignInRequest', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOS(1, 'email')
    ..aOS(2, 'password')
    ..hasRequiredFields = false
  ;

  SignInRequest._() : super();
  factory SignInRequest() => create();
  factory SignInRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignInRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SignInRequest clone() => SignInRequest()..mergeFromMessage(this);
  SignInRequest copyWith(void Function(SignInRequest) updates) => super.copyWith((message) => updates(message as SignInRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignInRequest create() => SignInRequest._();
  SignInRequest createEmptyInstance() => create();
  static $pb.PbList<SignInRequest> createRepeated() => $pb.PbList<SignInRequest>();
  @$core.pragma('dart2js:noInline')
  static SignInRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignInRequest>(create);
  static SignInRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class GetNewAccessTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetNewAccessTokenRequest', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOS(1, 'refreshToken', protoName: 'refreshToken')
    ..hasRequiredFields = false
  ;

  GetNewAccessTokenRequest._() : super();
  factory GetNewAccessTokenRequest() => create();
  factory GetNewAccessTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNewAccessTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetNewAccessTokenRequest clone() => GetNewAccessTokenRequest()..mergeFromMessage(this);
  GetNewAccessTokenRequest copyWith(void Function(GetNewAccessTokenRequest) updates) => super.copyWith((message) => updates(message as GetNewAccessTokenRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetNewAccessTokenRequest create() => GetNewAccessTokenRequest._();
  GetNewAccessTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GetNewAccessTokenRequest> createRepeated() => $pb.PbList<GetNewAccessTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNewAccessTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNewAccessTokenRequest>(create);
  static GetNewAccessTokenRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => clearField(1);
}

class GetNewAccessTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetNewAccessTokenResponse', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOM<OAuthToken>(1, 'token', subBuilder: OAuthToken.create)
    ..hasRequiredFields = false
  ;

  GetNewAccessTokenResponse._() : super();
  factory GetNewAccessTokenResponse() => create();
  factory GetNewAccessTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNewAccessTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetNewAccessTokenResponse clone() => GetNewAccessTokenResponse()..mergeFromMessage(this);
  GetNewAccessTokenResponse copyWith(void Function(GetNewAccessTokenResponse) updates) => super.copyWith((message) => updates(message as GetNewAccessTokenResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetNewAccessTokenResponse create() => GetNewAccessTokenResponse._();
  GetNewAccessTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GetNewAccessTokenResponse> createRepeated() => $pb.PbList<GetNewAccessTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNewAccessTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNewAccessTokenResponse>(create);
  static GetNewAccessTokenResponse _defaultInstance;

  @$pb.TagNumber(1)
  OAuthToken get token => $_getN(0);
  @$pb.TagNumber(1)
  set token(OAuthToken v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
  @$pb.TagNumber(1)
  OAuthToken ensureToken() => $_ensure(0);
}

class OAuthToken extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('OAuthToken', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOS(1, 'accessToken', protoName: 'accessToken')
    ..aInt64(2, 'expires')
    ..aOS(3, 'refreshToken', protoName: 'refreshToken')
    ..e<OAuthToken_TokenType>(4, 'type', $pb.PbFieldType.OE, defaultOrMaker: OAuthToken_TokenType.Unknown, valueOf: OAuthToken_TokenType.valueOf, enumValues: OAuthToken_TokenType.values)
    ..hasRequiredFields = false
  ;

  OAuthToken._() : super();
  factory OAuthToken() => create();
  factory OAuthToken.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OAuthToken.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  OAuthToken clone() => OAuthToken()..mergeFromMessage(this);
  OAuthToken copyWith(void Function(OAuthToken) updates) => super.copyWith((message) => updates(message as OAuthToken));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OAuthToken create() => OAuthToken._();
  OAuthToken createEmptyInstance() => create();
  static $pb.PbList<OAuthToken> createRepeated() => $pb.PbList<OAuthToken>();
  @$core.pragma('dart2js:noInline')
  static OAuthToken getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OAuthToken>(create);
  static OAuthToken _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get expires => $_getI64(1);
  @$pb.TagNumber(2)
  set expires($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpires() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpires() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refreshToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set refreshToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => clearField(3);

  @$pb.TagNumber(4)
  OAuthToken_TokenType get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(OAuthToken_TokenType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);
}

class SignInResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SignInResponse', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOM<OAuthToken>(1, 'token', subBuilder: OAuthToken.create)
    ..hasRequiredFields = false
  ;

  SignInResponse._() : super();
  factory SignInResponse() => create();
  factory SignInResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignInResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SignInResponse clone() => SignInResponse()..mergeFromMessage(this);
  SignInResponse copyWith(void Function(SignInResponse) updates) => super.copyWith((message) => updates(message as SignInResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignInResponse create() => SignInResponse._();
  SignInResponse createEmptyInstance() => create();
  static $pb.PbList<SignInResponse> createRepeated() => $pb.PbList<SignInResponse>();
  @$core.pragma('dart2js:noInline')
  static SignInResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignInResponse>(create);
  static SignInResponse _defaultInstance;

  @$pb.TagNumber(1)
  OAuthToken get token => $_getN(0);
  @$pb.TagNumber(1)
  set token(OAuthToken v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
  @$pb.TagNumber(1)
  OAuthToken ensureToken() => $_ensure(0);
}

class NewUser_Date extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('NewUser.Date', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, 'year', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'month', $pb.PbFieldType.O3)
    ..a<$core.int>(3, 'day', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  NewUser_Date._() : super();
  factory NewUser_Date() => create();
  factory NewUser_Date.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewUser_Date.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  NewUser_Date clone() => NewUser_Date()..mergeFromMessage(this);
  NewUser_Date copyWith(void Function(NewUser_Date) updates) => super.copyWith((message) => updates(message as NewUser_Date));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NewUser_Date create() => NewUser_Date._();
  NewUser_Date createEmptyInstance() => create();
  static $pb.PbList<NewUser_Date> createRepeated() => $pb.PbList<NewUser_Date>();
  @$core.pragma('dart2js:noInline')
  static NewUser_Date getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewUser_Date>(create);
  static NewUser_Date _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get day => $_getIZ(2);
  @$pb.TagNumber(3)
  set day($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDay() => $_has(2);
  @$pb.TagNumber(3)
  void clearDay() => clearField(3);
}

class NewUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('NewUser', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOS(1, 'email')
    ..aOS(2, 'password')
    ..aOS(3, 'name')
    ..aOM<NewUser_Date>(4, 'dateOfBirth', protoName: 'dateOfBirth', subBuilder: NewUser_Date.create)
    ..hasRequiredFields = false
  ;

  NewUser._() : super();
  factory NewUser() => create();
  factory NewUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  NewUser clone() => NewUser()..mergeFromMessage(this);
  NewUser copyWith(void Function(NewUser) updates) => super.copyWith((message) => updates(message as NewUser));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NewUser create() => NewUser._();
  NewUser createEmptyInstance() => create();
  static $pb.PbList<NewUser> createRepeated() => $pb.PbList<NewUser>();
  @$core.pragma('dart2js:noInline')
  static NewUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewUser>(create);
  static NewUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  NewUser_Date get dateOfBirth => $_getN(3);
  @$pb.TagNumber(4)
  set dateOfBirth(NewUser_Date v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDateOfBirth() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateOfBirth() => clearField(4);
  @$pb.TagNumber(4)
  NewUser_Date ensureDateOfBirth() => $_ensure(3);
}

class SignUpRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SignUpRequest', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOM<NewUser>(1, 'user', subBuilder: NewUser.create)
    ..hasRequiredFields = false
  ;

  SignUpRequest._() : super();
  factory SignUpRequest() => create();
  factory SignUpRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SignUpRequest clone() => SignUpRequest()..mergeFromMessage(this);
  SignUpRequest copyWith(void Function(SignUpRequest) updates) => super.copyWith((message) => updates(message as SignUpRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignUpRequest create() => SignUpRequest._();
  SignUpRequest createEmptyInstance() => create();
  static $pb.PbList<SignUpRequest> createRepeated() => $pb.PbList<SignUpRequest>();
  @$core.pragma('dart2js:noInline')
  static SignUpRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpRequest>(create);
  static SignUpRequest _defaultInstance;

  @$pb.TagNumber(1)
  NewUser get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(NewUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  NewUser ensureUser() => $_ensure(0);
}

class SignUpResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SignUpResponse', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SignUpResponse._() : super();
  factory SignUpResponse() => create();
  factory SignUpResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignUpResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SignUpResponse clone() => SignUpResponse()..mergeFromMessage(this);
  SignUpResponse copyWith(void Function(SignUpResponse) updates) => super.copyWith((message) => updates(message as SignUpResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignUpResponse create() => SignUpResponse._();
  SignUpResponse createEmptyInstance() => create();
  static $pb.PbList<SignUpResponse> createRepeated() => $pb.PbList<SignUpResponse>();
  @$core.pragma('dart2js:noInline')
  static SignUpResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpResponse>(create);
  static SignUpResponse _defaultInstance;
}

class GetPublicJwtKeyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetPublicJwtKeyRequest', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetPublicJwtKeyRequest._() : super();
  factory GetPublicJwtKeyRequest() => create();
  factory GetPublicJwtKeyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPublicJwtKeyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetPublicJwtKeyRequest clone() => GetPublicJwtKeyRequest()..mergeFromMessage(this);
  GetPublicJwtKeyRequest copyWith(void Function(GetPublicJwtKeyRequest) updates) => super.copyWith((message) => updates(message as GetPublicJwtKeyRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPublicJwtKeyRequest create() => GetPublicJwtKeyRequest._();
  GetPublicJwtKeyRequest createEmptyInstance() => create();
  static $pb.PbList<GetPublicJwtKeyRequest> createRepeated() => $pb.PbList<GetPublicJwtKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPublicJwtKeyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPublicJwtKeyRequest>(create);
  static GetPublicJwtKeyRequest _defaultInstance;
}

class GetPublicJwtKeyResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetPublicJwtKeyResponse', package: const $pb.PackageName('auth.v1'), createEmptyInstance: create)
    ..aOS(1, 'publicRsaKey', protoName: 'publicRsaKey')
    ..hasRequiredFields = false
  ;

  GetPublicJwtKeyResponse._() : super();
  factory GetPublicJwtKeyResponse() => create();
  factory GetPublicJwtKeyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPublicJwtKeyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GetPublicJwtKeyResponse clone() => GetPublicJwtKeyResponse()..mergeFromMessage(this);
  GetPublicJwtKeyResponse copyWith(void Function(GetPublicJwtKeyResponse) updates) => super.copyWith((message) => updates(message as GetPublicJwtKeyResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPublicJwtKeyResponse create() => GetPublicJwtKeyResponse._();
  GetPublicJwtKeyResponse createEmptyInstance() => create();
  static $pb.PbList<GetPublicJwtKeyResponse> createRepeated() => $pb.PbList<GetPublicJwtKeyResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPublicJwtKeyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPublicJwtKeyResponse>(create);
  static GetPublicJwtKeyResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get publicRsaKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicRsaKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPublicRsaKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicRsaKey() => clearField(1);
}

