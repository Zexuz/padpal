///
//  Generated code. Do not modify.
//  source: auth_v1/auth_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'auth_service.pb.dart' as $0;
export 'auth_service.pb.dart';

class AuthServiceClient extends $grpc.Client {
  static final _$signUp =
      $grpc.ClientMethod<$0.SignUpRequest, $0.SignUpResponse>(
          '/auth.v1.AuthService/SignUp',
          ($0.SignUpRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SignUpResponse.fromBuffer(value));
  static final _$signIn =
      $grpc.ClientMethod<$0.SignInRequest, $0.SignInResponse>(
          '/auth.v1.AuthService/SignIn',
          ($0.SignInRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SignInResponse.fromBuffer(value));
  static final _$getNewAccessToken = $grpc.ClientMethod<
          $0.GetNewAccessTokenRequest, $0.GetNewAccessTokenResponse>(
      '/auth.v1.AuthService/GetNewAccessToken',
      ($0.GetNewAccessTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetNewAccessTokenResponse.fromBuffer(value));
  static final _$getPublicJwtKey =
      $grpc.ClientMethod<$0.GetPublicJwtKeyRequest, $0.GetPublicJwtKeyResponse>(
          '/auth.v1.AuthService/GetPublicJwtKey',
          ($0.GetPublicJwtKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetPublicJwtKeyResponse.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.SignUpResponse> signUp($0.SignUpRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$signUp, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.SignInResponse> signIn($0.SignInRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$signIn, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetNewAccessTokenResponse> getNewAccessToken(
      $0.GetNewAccessTokenRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getNewAccessToken, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetPublicJwtKeyResponse> getPublicJwtKey(
      $0.GetPublicJwtKeyRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getPublicJwtKey, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.v1.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SignUpRequest, $0.SignUpResponse>(
        'SignUp',
        signUp_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignUpRequest.fromBuffer(value),
        ($0.SignUpResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignInRequest, $0.SignInResponse>(
        'SignIn',
        signIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignInRequest.fromBuffer(value),
        ($0.SignInResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetNewAccessTokenRequest,
            $0.GetNewAccessTokenResponse>(
        'GetNewAccessToken',
        getNewAccessToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetNewAccessTokenRequest.fromBuffer(value),
        ($0.GetNewAccessTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPublicJwtKeyRequest,
            $0.GetPublicJwtKeyResponse>(
        'GetPublicJwtKey',
        getPublicJwtKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPublicJwtKeyRequest.fromBuffer(value),
        ($0.GetPublicJwtKeyResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SignUpResponse> signUp_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SignUpRequest> request) async {
    return signUp(call, await request);
  }

  $async.Future<$0.SignInResponse> signIn_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SignInRequest> request) async {
    return signIn(call, await request);
  }

  $async.Future<$0.GetNewAccessTokenResponse> getNewAccessToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetNewAccessTokenRequest> request) async {
    return getNewAccessToken(call, await request);
  }

  $async.Future<$0.GetPublicJwtKeyResponse> getPublicJwtKey_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPublicJwtKeyRequest> request) async {
    return getPublicJwtKey(call, await request);
  }

  $async.Future<$0.SignUpResponse> signUp(
      $grpc.ServiceCall call, $0.SignUpRequest request);
  $async.Future<$0.SignInResponse> signIn(
      $grpc.ServiceCall call, $0.SignInRequest request);
  $async.Future<$0.GetNewAccessTokenResponse> getNewAccessToken(
      $grpc.ServiceCall call, $0.GetNewAccessTokenRequest request);
  $async.Future<$0.GetPublicJwtKeyResponse> getPublicJwtKey(
      $grpc.ServiceCall call, $0.GetPublicJwtKeyRequest request);
}
