part of 'notification_cubit.dart';

class NotificationState extends Equatable {
   NotificationState({this.notifications}){
    print("length ${notifications.length}");
   }

  final List<PushNotification> notifications;

  @override
  List<Object> get props => [notifications];

  NotificationState copyWith({
    List<PushNotification> notifications,
  }) {
    return NotificationState(notifications: notifications ?? this.notifications);
  }
}
