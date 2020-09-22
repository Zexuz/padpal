import 'dart:async';

enum Notification { chatMessage }

abstract class NotificationBase {
  final Notification type;

  const NotificationBase(this.type);
}

class ChatMessageNotification extends NotificationBase {
  final String content;

  ChatMessageNotification(this.content) : super(Notification.chatMessage);
}

class NotificationManager extends _NotificationManager {
  static NotificationManager _singleton = NotificationManager._internal();

  factory NotificationManager() {
    return _singleton;
  }

  NotificationManager._internal();
}

class _NotificationManager{
  StreamController<NotificationBase> _controller = StreamController();

  Stream<NotificationBase> get notification => _controller.stream.asBroadcastStream();

  void addChatNotification(String content) {
    _controller.sink.add(ChatMessageNotification(content));
  }
}
