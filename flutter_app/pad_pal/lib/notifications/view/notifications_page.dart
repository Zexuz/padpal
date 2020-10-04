import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/notifications/cubit/notification_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
            itemBuilder: (c, i) => Card(
              child: Notification(
                title: "Chioke Okonkwo",
                label: "Wants to be your PadelPal",
                onPrimaryPressed: () {},
              ),
            ),
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
    @required this.label,
    @required this.onPrimaryPressed,
    this.onSecondaryPressed,
  })  : assert(title != null),
        assert(label != null),
        assert(onPrimaryPressed != null);

  final String title;
  final String label;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

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
        Avatar(),
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
