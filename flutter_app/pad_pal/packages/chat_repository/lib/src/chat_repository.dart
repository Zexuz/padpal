import 'dart:async';

import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:chat_repository/generated/chat_service.pbgrpc.dart';

class ChatRepository {
  ChatRepository({ChatServiceClient chatServiceClient})
      : _chatServiceClient = chatServiceClient ??
            ChatServiceClient(GrpcChannelFactory().createChannel());

  final ChatServiceClient _chatServiceClient;

  final StreamController<String> streamController = StreamController();

  Future<void> sendMessage(String message) async {
    final call = _chatServiceClient.sendMessage(SendMessageRequest()..content = message);
    await call;
  }

  Future<void> startListenForMessages() async {

    // var res = Stream<int>.periodic(Duration(seconds: 1), (x) => x);
    final call = _chatServiceClient.subscribeToRoom(SubscribeToRoomRequest()..roomId = "SomeRoom");
    var res = await call;
    res.listen((value) {
      streamController.sink.add("some message ${value.message.content}");
    });
  }
}
