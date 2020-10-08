import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/generated/notification_v1/notification_service.pb.dart';
import 'package:notification_repository/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._notificationRepo)
      : assert(_notificationRepo != null),
        super(NotificationState(notifications: List.empty()));

  final NotificationRepository _notificationRepo;

  Future<void> loadNotifications() async {
    var notifications = await _notificationRepo.getNotifications();
    emit(state.copyWith(notifications: notifications));
  }
}
