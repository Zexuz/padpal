import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:notification_repository/generated/notification_v1/notification_service.pbgrpc.dart';

// Model to represented in the Notifications view
class Notification {
  String Type;
  String title;
  String body;
}

class NotificationRepository {
  NotificationRepository({NotificationClient notificationClient, TokenManager tokenManager})
      : _notificationClient = notificationClient ?? NotificationClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  NotificationClient _notificationClient;
  TokenManager _tokenManager;

  Future<void> sendFmcToken({@required String token}) async {
    assert(token != null);

    final callOptions =
        CallOptions(metadata: {'Authorization': "Bearer ${(await _tokenManager.getAccessToken()).token}"});
    final request = AppendFcmTokenToUserRequest()..fcmToken = token;

    var call = _notificationClient.appendFcmTokenToUser(request, options: callOptions);

    try {
      await call;
    } catch (e) {
      print("call to sendFmcToken failed ${e}");
    }
  }

  Future<List<PushNotification>> getNotifications() async {
    final callOptions =
        CallOptions(metadata: {'Authorization': "Bearer ${(await _tokenManager.getAccessToken()).token}"});
    final request = GetNotificationRequest();

    var call = _notificationClient.getNotification(request, options: callOptions);

    try {
      var res = await call;
      return res.notifications;
    } catch (e) {
      print("call to getNotifications failed ${e}");
      return List.empty();
    }
  }
}
