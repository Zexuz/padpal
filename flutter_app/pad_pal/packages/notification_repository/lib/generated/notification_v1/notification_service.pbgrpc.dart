///
//  Generated code. Do not modify.
//  source: notification_v1/notification_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'notification_service.pb.dart' as $1;
export 'notification_service.pb.dart';

class NotificationClient extends $grpc.Client {
  static final _$appendFcmTokenToUser = $grpc.ClientMethod<
          $1.AppendFcmTokenToUserRequest, $1.AppendFcmTokenToUserResponse>(
      '/notification.v1.Notification/AppendFcmTokenToUser',
      ($1.AppendFcmTokenToUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AppendFcmTokenToUserResponse.fromBuffer(value));
  static final _$getNotification =
      $grpc.ClientMethod<$1.GetNotificationRequest, $1.GetNotificationResponse>(
          '/notification.v1.Notification/GetNotification',
          ($1.GetNotificationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetNotificationResponse.fromBuffer(value));
  static final _$removeNotification = $grpc.ClientMethod<
          $1.RemoveNotificationRequest, $1.RemoveNotificationResponse>(
      '/notification.v1.Notification/RemoveNotification',
      ($1.RemoveNotificationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RemoveNotificationResponse.fromBuffer(value));

  NotificationClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.AppendFcmTokenToUserResponse> appendFcmTokenToUser(
      $1.AppendFcmTokenToUserRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$appendFcmTokenToUser, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.GetNotificationResponse> getNotification(
      $1.GetNotificationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getNotification, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.RemoveNotificationResponse> removeNotification(
      $1.RemoveNotificationRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$removeNotification, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class NotificationServiceBase extends $grpc.Service {
  $core.String get $name => 'notification.v1.Notification';

  NotificationServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.AppendFcmTokenToUserRequest,
            $1.AppendFcmTokenToUserResponse>(
        'AppendFcmTokenToUser',
        appendFcmTokenToUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AppendFcmTokenToUserRequest.fromBuffer(value),
        ($1.AppendFcmTokenToUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetNotificationRequest,
            $1.GetNotificationResponse>(
        'GetNotification',
        getNotification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetNotificationRequest.fromBuffer(value),
        ($1.GetNotificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemoveNotificationRequest,
            $1.RemoveNotificationResponse>(
        'RemoveNotification',
        removeNotification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RemoveNotificationRequest.fromBuffer(value),
        ($1.RemoveNotificationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.AppendFcmTokenToUserResponse> appendFcmTokenToUser_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AppendFcmTokenToUserRequest> request) async {
    return appendFcmTokenToUser(call, await request);
  }

  $async.Future<$1.GetNotificationResponse> getNotification_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetNotificationRequest> request) async {
    return getNotification(call, await request);
  }

  $async.Future<$1.RemoveNotificationResponse> removeNotification_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RemoveNotificationRequest> request) async {
    return removeNotification(call, await request);
  }

  $async.Future<$1.AppendFcmTokenToUserResponse> appendFcmTokenToUser(
      $grpc.ServiceCall call, $1.AppendFcmTokenToUserRequest request);
  $async.Future<$1.GetNotificationResponse> getNotification(
      $grpc.ServiceCall call, $1.GetNotificationRequest request);
  $async.Future<$1.RemoveNotificationResponse> removeNotification(
      $grpc.ServiceCall call, $1.RemoveNotificationRequest request);
}
