import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/generated/notification_v1/notification_service.pb.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/notifications/cubit/notification_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:social_repository/generated/social_v1/social_service.pb.dart';
import 'package:social_repository/social_repository.dart';

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
                        final snackBar = SnackBar(content: Text('Not implemented'));
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
                case PushNotification_Notification.friendRequestReceived:
                  final event = pushNotification.friendRequestReceived;
                  return Card(
                    child: Notification(
                      title: event.name,
                      label: "Wants to be your PadelPal",
                      imgUrl: "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg",
                      // TODO fetch users image
                      onPrimaryPressed: () async {
                        try {
                          await context
                              .repository<SocialRepository>()
                              .responseToFriendRequest(event.userId, RespondToFriendRequestRequest_Action.ACCEPT);
                          final snackBar = SnackBar(content: Text('Yay! You are now friends!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          final snackBar = SnackBar(content: Text('Failed to accept friend request'));
                          Scaffold.of(context).showSnackBar(snackBar);
                          print(e);
                        }
                      },
                      onSecondaryPressed: () async {
                        try {
                          await context
                              .repository<SocialRepository>()
                              .responseToFriendRequest(event.userId, RespondToFriendRequestRequest_Action.DECLINE);
                          final snackBar = SnackBar(content: Text('You have declined the friend request'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          final snackBar = SnackBar(content: Text('Failed to accept friend request'));
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
                      title: event.name,
                      label: "Has accepted your friend request. Say hi!",
                      imgUrl: "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg",
                      // TODO fetch users image
                      onPrimaryPressed: () async {
                        final snackBar = SnackBar(content: Text('Todo not implemented'));
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                    ),
                  );
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

class Notification extends StatelessWidget {
  const Notification({
    @required this.title,
    @required this.imgUrl,
    @required this.label,
    @required this.onPrimaryPressed,
    this.onSecondaryPressed,
  })  : assert(title != null),
        assert(label != null),
        assert(onPrimaryPressed != null);

  final String title;
  final String label;
  final String imgUrl;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

  static const radius = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = 25.0;

    final onlyOneAction = onSecondaryPressed == null;

    final primaryIcon = onlyOneAction
        ? Icon(
            Icons.arrow_forward_ios,
            size: iconSize,
          )
        : Icon(
            Icons.check,
            color: Colors.white,
            size: iconSize,
          );

    final primFillColor = onlyOneAction ? Colors.transparent : theme.primaryColor;

    return Row(
      children: [
        Avatar(
          radius: radius,
          url: imgUrl,
          borderWidth: 0,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.headline6),
              Text(label, style: theme.textTheme.bodyText1),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (this.onSecondaryPressed != null)
              _IconButton(
                onPressed: onSecondaryPressed,
                child: Icon(
                  Icons.cancel,
                  size: iconSize,
                ),
                fillColor: Colors.grey,
              ),
            _IconButton(
              onPressed: onPrimaryPressed,
              child: primaryIcon,
              fillColor: primFillColor,
            )
          ],
        )
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    @required this.onPressed,
    @required this.fillColor,
    @required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: fillColor,
      highlightElevation: 0,
      child: child,
      padding: EdgeInsets.all(7.0),
      shape: CircleBorder(),
    );
  }
}
