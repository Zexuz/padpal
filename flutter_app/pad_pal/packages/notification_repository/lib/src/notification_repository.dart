import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:notification_repository/generated/notification_v1/notification_service.pbgrpc.dart';

class NotificationRepository {
  NotificationRepository({NotificationClient notificationClient, TokenManager tokenManager})
      : _notificationClient = notificationClient ?? NotificationClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  NotificationClient _notificationClient;
  TokenManager _tokenManager;

  Future<void> sendFmcToken({@required String token}) async {
    assert(token != null);

    final callOptions = CallOptions(metadata: {'Authorization': "Bearer ${_tokenManager.accessToken.token}"});
    final request = AppendFcmTokenToUserRequest()..fcmToken = token;

    var call = _notificationClient.appendFcmTokenToUser(request, options: callOptions);

    try{
      await call;
    }catch (e){
      print("call to sendFmcToken failed ${e}");
    }
  }
}
