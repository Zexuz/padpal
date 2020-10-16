import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';
import 'package:social_repository/social_repository.dart';

enum PlayerState {
  Creator,
  Accepted,
  Pending,
  Free,
}

class Player {
  const Player({this.profile, this.state, this.action});

  final Profile profile;
  final PlayerState state;
  final Widget action;
}

class CreateEventAddPlayers extends StatelessWidget {
  const CreateEventAddPlayers({
    @required this.players,
  });

  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = 24.0;

    const offset = (radius * 2);

    final widgets = <Widget>[];

    for (var value in players ?? <Player>[]) {
      if (value.state == PlayerState.Creator) continue;
      widgets.add(RawSpot(
        avatar: Avatar(
          url: value.profile.imageUrl,
          radius: radius,
          borderWidth: 0,
          color: theme.primaryColor,
          elevation: 0,
          innerBorderWidth: 0,
          fallback: "AG",
        ),
        name: value.profile.name,
        label: "Beginner",
        action: value.action,
        addDivider: true,
        offset: offset,
      ));
    }

    for (var i = widgets.length; i < 4; i++) {
      widgets.add(
        RawSpot(
          avatar: DottedAvatar(
            radius: radius,
          ),
          name: "Player ${i + 1}",
          label: "Free spot",
          action: ButtonSmallPrimary(
            stretch: false,
            onPressed: () => {},
            text: "Add friend",
            isDisabled: false,
          ),
          addDivider: i != 3,
          offset: offset,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     _RawSpot(
    //       avatar: Avatar(
    //         url: url,
    //         radius: radius,
    //         borderWidth: 0,
    //         color: theme.primaryColor,
    //         elevation: 0,
    //         innerBorderWidth: 0,
    //         fallback: "AG",
    //       ),
    //       name: "Andries Grootoonk",
    //       label: "Beginner",
    //       action: ButtonSmallSecondary(
    //         stretch: false,
    //         onPressed: () => {},
    //         text: "Remove",
    //         isDisabled: false,
    //       ),
    //       addDivider: true,
    //       offset: offset,
    //     ),
    //     _RawSpot(
    //       avatar: DottedAvatar(
    //         radius: radius,
    //       ),
    //       name: "Player 3",
    //       label: "Free spot",
    //       action: ButtonSmallPrimary(
    //         stretch: false,
    //         onPressed: () => {},
    //         text: "Add friend",
    //         isDisabled: false,
    //       ),
    //       addDivider: true,
    //       offset: offset,
    //     ),
    //     _RawSpot(
    //       avatar: DottedAvatar(
    //         radius: radius,
    //       ),
    //       name: "Player 4",
    //       label: "Free spot",
    //       action: ButtonSmallPrimary(
    //         stretch: false,
    //         onPressed: () => {},
    //         text: "Add friend",
    //         isDisabled: false,
    //       ),
    //       addDivider: false,
    //       offset: offset,
    //     ),
    //   ],
    // );
  }
}

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
      action: TextButton(
        onPressed: null,
        child: Text("Pending..."),
      ),
      addDivider: true,
      offset: offset,
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
    this.addDivider = false,
  }) : super(key: key);

  final Widget action;
  final Widget avatar;
  final String name;
  final String label;
  final bool addDivider;
  final double offset;

  static const rightPadding = 16.0;
  static const orPadding = 16.0;
  static const dividerHeight = 24.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        ),
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