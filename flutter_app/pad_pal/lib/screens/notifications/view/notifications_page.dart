import 'package:flutter/cupertino.dart' hide Notification;
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/generated/notification_v1/notification_service.pb.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_repository/generated/social_v1/social_service.pb.dart';
import 'package:social_repository/social_repository.dart';

import '../cubit/notification_cubit.dart';
import '../components/notification.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),
      backgroundColor: const Color(0xFFDDE2E9),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: NotificationView(),
      ),
    );
  }
}

class NotificationView extends StatelessWidget {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) => previous.notifications.length != current.notifications.length,
      builder: (context, state) {
        return SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(waterDropColor: theme.primaryColor),
          controller: _refreshController,
          onRefresh: () async {
            await _onRefresh(context);
          },
          child: ListView.builder(
            itemBuilder: (c, i) {
              final pushNotification = state.notifications[i];

              switch (pushNotification.whichNotification()) {
                case PushNotification_Notification.chatMessageReceived:
                  return Card(
                    child: Notification(
                      title: "ChatMessage Received",
                      label: "TODO",
                      imgUrl: "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg",
                      onPrimaryPressed: () {
                        final snackBar = SnackBarFactory.buildSnackBar("NOT IMPLEMENTED", SnackBarType.normal);
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
                case PushNotification_Notification.friendRequestReceived:
                  final event = pushNotification.friendRequestReceived;
                  return Card(
                    child: Notification(
                      title: event.player.name,
                      label: "Wants to be your PadelPal",
                      imgUrl: "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg",
                      // TODO fetch users image
                      onPrimaryPressed: () async {
                        try {
                          await context.repository<SocialRepository>().responseToFriendRequest(
                              event.player.userId, RespondToFriendRequestRequest_Action.ACCEPT);
                          final snackBar =
                              SnackBarFactory.buildSnackBar('Yay! You are now friends!', SnackBarType.success);
                          Scaffold.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          final snackBar =
                              SnackBarFactory.buildSnackBar('Failed to accept friend request', SnackBarType.error);
                          Scaffold.of(context).showSnackBar(snackBar);
                          print(e);
                        }
                      },
                      onSecondaryPressed: () async {
                        try {
                          await context.repository<SocialRepository>().responseToFriendRequest(
                              event.player.userId, RespondToFriendRequestRequest_Action.DECLINE);
                          final snackBar = SnackBarFactory.buildSnackBar('You have declined the friend request');
                          Scaffold.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          final snackBar =
                              SnackBarFactory.buildSnackBar('Failed to decline friend request', SnackBarType.error);
                          Scaffold.of(context).showSnackBar(snackBar);
                          print(e);
                        }
                      },
                    ),
                  );
                case PushNotification_Notification.friendRequestAccepted:
                  final event = pushNotification.friendRequestAccepted;
                  return Card(
                    child: Notification(
                      title: event.player.name,
                      label: "Has accepted your friend request. Say hi!",
                      imgUrl: "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg",
                      // TODO fetch users image
                      onPrimaryPressed: () async {
                        final snackBar = SnackBar(content: Text('Todo not implemented'));
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
                case PushNotification_Notification.invitedToGame:
                  final event = pushNotification.invitedToGame;
                  return Card(
                    child: Notification(
                      title: event.gameInfo.creator.name,
                      label:
                          "Has invited you to play a game on ${DateTime.fromMillisecondsSinceEpoch(event.gameInfo.startTime.toInt() * 1000)} @ ${event.gameInfo.location.name} for ${event.gameInfo.durationInMinutes} minutes",
                      imgUrl: "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg",
                      // TODO fetch users image
                      onPrimaryPressed: () async {
                        final snackBar = SnackBar(content: Text('Todo not implemented'));
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
                case PushNotification_Notification.requestedToJoinGame:
                  final event = pushNotification.requestedToJoinGame;
                  return Card(
                    child: Notification(
                      title: event.user.name,
                      label: "Has requested to join your game!",
                      imgUrl: event.user.imgUrl,
                      // TODO fetch users image
                      onPrimaryPressed: () async {
                        final snackBar = SnackBar(content: Text('Todo not implemented'));
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
                  break;
                case PushNotification_Notification.notSet:
                  throw Exception("Notification type not set, notification: ${pushNotification}");
              }

              throw Exception("No matching cases was found for notification: ${pushNotification}");
            },
            itemCount: state.notifications.length,
          ),
        );
      },
    );
  }

  Future _onRefresh(BuildContext context) async {
    await context.bloc<NotificationCubit>().loadNotifications();
    _refreshController.refreshCompleted();
  }
}
