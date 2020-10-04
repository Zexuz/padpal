part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({this.notifications});

  final List<PushNotification> notifications;

  @override
  List<Object> get props => [notifications];

  NotificationState copyWith({
    List<PushNotification> notifications,
  }) {
    return NotificationState(notifications: notifications ?? this.notifications);
  }
}
