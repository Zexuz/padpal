import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';
import 'package:social_repository/social_repository.dart';

class CreatorSpot extends StatelessWidget {
  const CreatorSpot({
    Key key,
    @required this.profile,
    @required this.radius,
    @required this.offset,
  }) : super(key: key);

  final double radius;
  final double offset;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: RawSpot(
        avatar: Avatar(
          url: profile.imageUrl,
          fallback: "AB",
          radius: radius,
          borderWidth: 3.0,
          color: theme.primaryColor,
          elevation: 0,
          innerBorderWidth: 2.0,
        ),
        name: profile.name,
        label: "Beginner",
        offset: offset + 5.0,
        addDivider: true,
      ),
      transform: Matrix4.translationValues(-5.0, 0, 0.0),
    );
  }
}

class InvitedSpot extends StatelessWidget {
  const InvitedSpot({
    Key key,
    @required this.profile,
    @required this.radius,
    @required this.offset,
    @required this.onTap,
  }) : super(key: key);

  final double radius;
  final double offset;
  final Profile profile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RawSpot(
      avatar: Avatar(
        url: profile.imageUrl,
        radius: radius,
        borderWidth: 0,
        color: theme.primaryColor,
        elevation: 0,
        innerBorderWidth: 0,
        fallback: "AG",
      ),
      name: profile.name,
      label: "Beginner",
      action: OrWrapper(
        child: ButtonSmallSecondary(
          stretch: false,
          onPressed: onTap,
          text: "Remove",
          isDisabled: false,
        ),
      ),
      addDivider: true,
      offset: offset,
    );
  }
}

class PendingSpot extends StatelessWidget {
  const PendingSpot({
    Key key,
    @required this.profile,
    @required this.radius,
    @required this.offset,
  }) : super(key: key);

  final double radius;
  final double offset;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RawSpot(
      avatar: Avatar(
        url: profile.imageUrl,
        radius: radius,
        borderWidth: 0,
        color: theme.primaryColor,
        elevation: 0,
        innerBorderWidth: 0,
        fallback: "AG",
      ),
      name: profile.name,
      label: "Beginner",
      action: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Text("Pending..."),
      ),
      addDivider: true,
      offset: offset,
      opacity: 0.5,
    );
  }
}

class FreeSpot extends StatelessWidget {
  const FreeSpot({
    Key key,
    @required this.radius,
    @required this.offset,
    @required this.onTap,
    @required this.playerNumber,
    this.addDivider = true,
  }) : super(key: key);

  final double radius;
  final double offset;
  final VoidCallback onTap;
  final int playerNumber;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    return RawSpot(
      avatar: DottedAvatar(
        radius: radius,
      ),
      name: "Player $playerNumber",
      label: "Free spot",
      action: OrWrapper(
        child: ButtonSmallPrimary(
          stretch: false,
          onPressed: onTap,
          text: "Invite friend",
          isDisabled: false,
        ),
      ),
      addDivider: addDivider,
      offset: offset,
    );
  }
}

class OrWrapper extends StatelessWidget {
  const OrWrapper({Key, key, @required this.child}) : super(key: key);

  final Widget child;

  static const orPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: orPadding, right: orPadding),
          child: const Text("or"),
        ),
        child
      ],
    );
  }
}

// TODO Maybe user ListTile? BoxDecortaion lowerSide?
class RawSpot extends StatelessWidget {
  const RawSpot({
    Key key,
    this.action,
    @required this.avatar,
    @required this.name,
    @required this.label,
    @required this.offset,
    this.opacity,
    this.addDivider = false,
  }) : super(key: key);

  final Widget action;
  final Widget avatar;
  final String name;
  final String label;
  final bool addDivider;
  final double offset;
  final double opacity;

  static const rightPadding = 16.0;
  static const orPadding = 16.0;
  static const dividerHeight = 24.0;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: rightPadding),
          child: avatar,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(label),
            ],
          ),
        ),
        if (action != null) action,
      ],
    );

    return Column(
      children: [
        opacity != null
            ? Opacity(
                opacity: opacity,
                child: child,
              )
            : child,
        if (addDivider)
          Divider(
            thickness: 2,
            height: dividerHeight,
            indent: offset + rightPadding,
          ),
      ],
    );
  }
}
