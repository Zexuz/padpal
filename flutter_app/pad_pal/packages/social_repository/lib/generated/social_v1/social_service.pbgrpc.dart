///
//  Generated code. Do not modify.
//  source: social_v1/social_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'social_service.pb.dart' as $0;
export 'social_service.pb.dart';

class SocialClient extends $grpc.Client {
  static final _$sendMessage =
      $grpc.ClientMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
          '/social.v1.Social/SendMessage',
          ($0.SendMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SendMessageResponse.fromBuffer(value));
  static final _$createRoom =
      $grpc.ClientMethod<$0.CreateRoomRequest, $0.CreateRoomResponse>(
          '/social.v1.Social/CreateRoom',
          ($0.CreateRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateRoomResponse.fromBuffer(value));
  static final _$getRoomsWhereUserIsParticipating = $grpc.ClientMethod<
          $0.GetRoomsWhereUserIsParticipatingRequest,
          $0.GetRoomsWhereUserIsParticipatingResponse>(
      '/social.v1.Social/GetRoomsWhereUserIsParticipating',
      ($0.GetRoomsWhereUserIsParticipatingRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetRoomsWhereUserIsParticipatingResponse.fromBuffer(value));
  static final _$getRoom =
      $grpc.ClientMethod<$0.GetRoomRequest, $0.GetRoomResponse>(
          '/social.v1.Social/GetRoom',
          ($0.GetRoomRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetRoomResponse.fromBuffer(value));
  static final _$searchForProfile = $grpc.ClientMethod<
          $0.SearchForProfileRequest, $0.SearchForProfileResponse>(
      '/social.v1.Social/SearchForProfile',
      ($0.SearchForProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SearchForProfileResponse.fromBuffer(value));
  static final _$getProfile =
      $grpc.ClientMethod<$0.GetProfileRequest, $0.GetProfileResponse>(
          '/social.v1.Social/GetProfile',
          ($0.GetProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetProfileResponse.fromBuffer(value));
  static final _$sendFriendRequest = $grpc.ClientMethod<
          $0.SendFriendRequestRequest, $0.SendFriendRequestResponse>(
      '/social.v1.Social/SendFriendRequest',
      ($0.SendFriendRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.SendFriendRequestResponse.fromBuffer(value));
  static final _$respondToFriendRequest = $grpc.ClientMethod<
          $0.RespondToFriendRequestRequest, $0.RespondToFriendRequestResponse>(
      '/social.v1.Social/RespondToFriendRequest',
      ($0.RespondToFriendRequestRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RespondToFriendRequestResponse.fromBuffer(value));
  static final _$myProfile =
      $grpc.ClientMethod<$0.MyProfileRequest, $0.MyProfileResponse>(
          '/social.v1.Social/MyProfile',
          ($0.MyProfileRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MyProfileResponse.fromBuffer(value));
  static final _$changeProfilePicture = $grpc.ClientMethod<
          $0.ChangeProfilePictureRequest, $0.ChangeProfilePictureResponse>(
      '/social.v1.Social/ChangeProfilePicture',
      ($0.ChangeProfilePictureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ChangeProfilePictureResponse.fromBuffer(value));

  SocialClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.SendMessageResponse> sendMessage(
      $0.SendMessageRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$sendMessage, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.CreateRoomResponse> createRoom(
      $0.CreateRoomRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createRoom, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetRoomsWhereUserIsParticipatingResponse>
      getRoomsWhereUserIsParticipating(
          $0.GetRoomsWhereUserIsParticipatingRequest request,
          {$grpc.CallOptions options}) {
    final call = $createCall(_$getRoomsWhereUserIsParticipating,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetRoomResponse> getRoom($0.GetRoomRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getRoom, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.SearchForProfileResponse> searchForProfile(
      $0.SearchForProfileRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$searchForProfile, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.GetProfileResponse> getProfile(
      $0.GetProfileRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getProfile, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.SendFriendRequestResponse> sendFriendRequest(
      $0.SendFriendRequestRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$sendFriendRequest, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.RespondToFriendRequestResponse>
      respondToFriendRequest($0.RespondToFriendRequestRequest request,
          {$grpc.CallOptions options}) {
    final call = $createCall(
        _$respondToFriendRequest, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.MyProfileResponse> myProfile(
      $0.MyProfileRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$myProfile, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.ChangeProfilePictureResponse> changeProfilePicture(
      $0.ChangeProfilePictureRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$changeProfilePicture, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class SocialServiceBase extends $grpc.Service {
  $core.String get $name => 'social.v1.Social';

  SocialServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.SendMessageRequest, $0.SendMessageResponse>(
            'SendMessage',
            sendMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SendMessageRequest.fromBuffer(value),
            ($0.SendMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateRoomRequest, $0.CreateRoomResponse>(
        'CreateRoom',
        createRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateRoomRequest.fromBuffer(value),
        ($0.CreateRoomResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRoomsWhereUserIsParticipatingRequest,
            $0.GetRoomsWhereUserIsParticipatingResponse>(
        'GetRoomsWhereUserIsParticipating',
        getRoomsWhereUserIsParticipating_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRoomsWhereUserIsParticipatingRequest.fromBuffer(value),
        ($0.GetRoomsWhereUserIsParticipatingResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRoomRequest, $0.GetRoomResponse>(
        'GetRoom',
        getRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRoomRequest.fromBuffer(value),
        ($0.GetRoomResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchForProfileRequest,
            $0.SearchForProfileResponse>(
        'SearchForProfile',
        searchForProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchForProfileRequest.fromBuffer(value),
        ($0.SearchForProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProfileRequest, $0.GetProfileResponse>(
        'GetProfile',
        getProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProfileRequest.fromBuffer(value),
        ($0.GetProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendFriendRequestRequest,
            $0.SendFriendRequestResponse>(
        'SendFriendRequest',
        sendFriendRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendFriendRequestRequest.fromBuffer(value),
        ($0.SendFriendRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RespondToFriendRequestRequest,
            $0.RespondToFriendRequestResponse>(
        'RespondToFriendRequest',
        respondToFriendRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RespondToFriendRequestRequest.fromBuffer(value),
        ($0.RespondToFriendRequestResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MyProfileRequest, $0.MyProfileResponse>(
        'MyProfile',
        myProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MyProfileRequest.fromBuffer(value),
        ($0.MyProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChangeProfilePictureRequest,
            $0.ChangeProfilePictureResponse>(
        'ChangeProfilePicture',
        changeProfilePicture_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChangeProfilePictureRequest.fromBuffer(value),
        ($0.ChangeProfilePictureResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendMessageResponse> sendMessage_Pre($grpc.ServiceCall call,
      $async.Future<$0.SendMessageRequest> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$0.CreateRoomResponse> createRoom_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateRoomRequest> request) async {
    return createRoom(call, await request);
  }

  $async.Future<$0.GetRoomsWhereUserIsParticipatingResponse>
      getRoomsWhereUserIsParticipating_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.GetRoomsWhereUserIsParticipatingRequest>
              request) async {
    return getRoomsWhereUserIsParticipating(call, await request);
  }

  $async.Future<$0.GetRoomResponse> getRoom_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetRoomRequest> request) async {
    return getRoom(call, await request);
  }

  $async.Future<$0.SearchForProfileResponse> searchForProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchForProfileRequest> request) async {
    return searchForProfile(call, await request);
  }

  $async.Future<$0.GetProfileResponse> getProfile_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetProfileRequest> request) async {
    return getProfile(call, await request);
  }

  $async.Future<$0.SendFriendRequestResponse> sendFriendRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SendFriendRequestRequest> request) async {
    return sendFriendRequest(call, await request);
  }

  $async.Future<$0.RespondToFriendRequestResponse> respondToFriendRequest_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RespondToFriendRequestRequest> request) async {
    return respondToFriendRequest(call, await request);
  }

  $async.Future<$0.MyProfileResponse> myProfile_Pre($grpc.ServiceCall call,
      $async.Future<$0.MyProfileRequest> request) async {
    return myProfile(call, await request);
  }

  $async.Future<$0.ChangeProfilePictureResponse> changeProfilePicture_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ChangeProfilePictureRequest> request) async {
    return changeProfilePicture(call, await request);
  }

  $async.Future<$0.SendMessageResponse> sendMessage(
      $grpc.ServiceCall call, $0.SendMessageRequest request);
  $async.Future<$0.CreateRoomResponse> createRoom(
      $grpc.ServiceCall call, $0.CreateRoomRequest request);
  $async.Future<$0.GetRoomsWhereUserIsParticipatingResponse>
      getRoomsWhereUserIsParticipating($grpc.ServiceCall call,
          $0.GetRoomsWhereUserIsParticipatingRequest request);
  $async.Future<$0.GetRoomResponse> getRoom(
      $grpc.ServiceCall call, $0.GetRoomRequest request);
  $async.Future<$0.SearchForProfileResponse> searchForProfile(
      $grpc.ServiceCall call, $0.SearchForProfileRequest request);
  $async.Future<$0.GetProfileResponse> getProfile(
      $grpc.ServiceCall call, $0.GetProfileRequest request);
  $async.Future<$0.SendFriendRequestResponse> sendFriendRequest(
      $grpc.ServiceCall call, $0.SendFriendRequestRequest request);
  $async.Future<$0.RespondToFriendRequestResponse> respondToFriendRequest(
      $grpc.ServiceCall call, $0.RespondToFriendRequestRequest request);
  $async.Future<$0.MyProfileResponse> myProfile(
      $grpc.ServiceCall call, $0.MyProfileRequest request);
  $async.Future<$0.ChangeProfilePictureResponse> changeProfilePicture(
      $grpc.ServiceCall call, $0.ChangeProfilePictureRequest request);
}
