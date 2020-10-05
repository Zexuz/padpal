import 'dart:async';

import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:social_repository/generated/social_v1/social_service.pbgrpc.dart';

class SocialRepository {
  SocialRepository({SocialClient socialClient})
      : _chatServiceClient = socialClient ?? SocialClient(GrpcChannelFactory().createChannel());

  final SocialClient _chatServiceClient;

  final StreamController<String> streamController = StreamController();

  Future<void> sendMessage(String message) async {
    final call = _chatServiceClient.sendMessage(SendMessageRequest()..content = message);
    await call;
  }
}
