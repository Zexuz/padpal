import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/factories/snack_bar_factory.dart';
import 'package:pad_pal/screens/event/create_event/view/create_event_add_players_step.dart';
import 'package:pad_pal/screens/profile/view/profile_from_id_page.dart';
import 'package:pad_pal/screens/result/view/result_divide_teams_page.dart';
import 'package:pad_pal/theme.dart';

class EventDetailsView extends StatelessWidget {
  static Route<void> route(BuildContext context, GameInfo gameInfo) {
    return MaterialPageRoute<void>(
      builder: (context) => EventDetailsView(gameInfo),
    );
  }

  const EventDetailsView(this.gameInfo);

  final GameInfo gameInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: "Details"),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Players(gameInfo: gameInfo),
            ),
            EventDetailsBulletPoints(gameInfo: gameInfo),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TitleAndSubtitle(title: "Information", subtitle: "Message from Anton:"),
                  RichText(
                    text: TextSpan(
                        text: 'Hi guys! \n\n'
                            'Me and my friend Andries are new to this sport and we are looking for two players bla bla bla...',
                        style: theme.textTheme.bodyText1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Players extends StatelessWidget {
  const Players({
    Key key,
    @required this.gameInfo,
  }) : super(key: key);

  final GameInfo gameInfo;

  _goToProfile(BuildContext context, int userId) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => ProfileFromId(gameInfo.publicInfo.creator.userId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const radius = 24.0;

    const offset = (radius * 2);

    return Column(
      children: [
        GoToAddResult(
          onTap: () {
            Navigator.of(context).push(ResultDivideTeamsPage.route(gameInfo));
          },
        ),
        SizedBox(height: 12),
        GoToConversation(
          onTap: () {
            Navigator.of(context).push(ResultDivideTeamsPage.route(gameInfo));
          },
        ),
        Divider(
          thickness: 2,
          height: 24 * 2.0,
          color: AppTheme.grayBorder,
        ),
        Price(gameInfo: gameInfo),
        TitleAndSubtitle(title: "Players", subtitle: "Lorem ipsom dolar sit amet"),
        BlocBuilder<MeCubit, MeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Container();
            }

            final me = gameInfo.publicInfo.playerRequestedToJoin
                .firstWhere((e) => e.userId == state.me.userId, orElse: () => null);

            final amICreator = gameInfo.publicInfo.creator.userId == state.me.userId;
            final iHaveAlreadyApplied = me != null;

            final players = <Widget>[
              CreatorSpot(
                user: SpotData.fromUser(gameInfo.publicInfo.creator),
                radius: radius,
                offset: offset,
                onTap: () => _goToProfile(context, gameInfo.publicInfo.creator.userId),
              ),
            ];

            for (var value in gameInfo.publicInfo.players) {
              players.add(AcceptedSpot(
                user: SpotData.fromUser(value),
                radius: radius,
                offset: offset,
                onTap: () => _goToProfile(context, value.userId),
              ));
            }

            if (me != null)
              players.add(PendingSpot(
                user: SpotData.fromUser(me),
                radius: radius,
                offset: offset,
              ));

            for (var i = players.length; i < 4; i++) {
              players.add(FreeSpot(
                radius: radius,
                offset: offset,
                onTap: () => _onApply(context),
                actionText: amICreator || iHaveAlreadyApplied ? null : "Apply",
                useOrWrapper: false,
                playerNumber: i + 1,
              ));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: players,
            );
          },
        ),
      ],
    );
  }

  Future<void> _onApply(BuildContext context) async {
    try {
      await context.repository<GameRepository>().requestToJoinGame(gameInfo.publicInfo.id);
      Scaffold.of(context).showSnackBar(SnackBarFactory.buildSnackBar("Request sent!"));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBarFactory.buildSnackBar("Request failed", SnackBarType.error));
      rethrow;
    }
  }
}

class FreeSpotBuilder extends StatelessWidget {
  const FreeSpotBuilder({
    Key key,
    @required this.gameInfo,
    @required this.radius,
    @required this.offset,
    @required this.playerNumber,
  }) : super(key: key);

  final GameInfo gameInfo;
  final double radius;
  final double offset;
  final int playerNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeCubit, MeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container();
        }
        final amICreator = gameInfo.publicInfo.creator.userId == state.me.userId;

        return FreeSpot(
          radius: radius,
          offset: offset,
          onTap: () => print("Tapped Invite"),
          actionText: amICreator ? null : "Apply",
          useOrWrapper: false,
          playerNumber: playerNumber,
        );
      },
    );
  }
}

class EventDetailsBulletPoints extends StatelessWidget {
  const EventDetailsBulletPoints({
    Key key,
    @required this.gameInfo,
  }) : super(key: key);

  final GameInfo gameInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F7F9),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TitleAndSubtitle(title: "Details", subtitle: "Lorem ipsom dolar sit amet"),
            ListTile(
              title: Text("Wed 23 Sep, 12.00-13.00 pm"),
              subtitle: Text("Next week"),
              leading: Icon(Icons.calendar_today),
            ),
            ListTile(
              title: Text("Delsjön Padel Center"),
              subtitle: Text("Göteborg"),
              leading: Icon(Icons.place),
            ),
            ListTile(
              title: Text("9 (hall C)"),
              subtitle: Text("Court number"),
              leading: Icon(Icons.directions),
            ),
            ListTile(
              title: Text(gameInfo.publicInfo.courtType.toString()),
              subtitle: Text("Lorem ipsum"),
              leading: Icon(Icons.house),
            ),
            ListTile(
              title: Text("${gameInfo.publicInfo.pricePerPerson} kr"),
              subtitle: Text("Price per person"),
              leading: Icon(Icons.label),
            ),
          ],
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    Key key,
    @required this.gameInfo,
  }) : super(key: key);

  final GameInfo gameInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoTile(
      title: Text(
        "${gameInfo.publicInfo.pricePerPerson} kr",
        style: theme.textTheme.headline3.copyWith(fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        "Price per person",
        style: theme.textTheme.headline5.copyWith(color: AppTheme.secondaryColorOrange),
      ),
      leading: Icon(
        CupertinoIcons.tag_fill,
        color: AppTheme.secondaryColorOrange,
        size: 28,
      ),
      boxDecoration: BoxDecoration(
        color: AppTheme.secondaryColorOrangeWithOpacity,
        border: Border.all(color: AppTheme.secondaryColorOrange, width: 1.5),
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }
}

class GoToConversation extends StatelessWidget {
  const GoToConversation({@required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoTile(
      title: Text(
        "Start a conversation",
        style: theme.textTheme.headline3,
      ),
      subtitle: Text(
        "with Name, Name, and Name",
        style: theme.textTheme.headline5,
      ),
      leading: Icon(
        CupertinoIcons.chat_bubble_fill,
        size: 28,
      ),
      onTap: onTap,
    );
  }
}

class GoToAddResult extends StatelessWidget {
  const GoToAddResult({@required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoTile(
      title: Text(
        "Add result",
        style: theme.textTheme.headline3,
      ),
      leading: Icon(
        CupertinoIcons.stopwatch_fill,
        size: 28,
      ),
      onTap: onTap,
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({
    Key key,
    @required this.leading,
    @required this.title,
    this.subtitle,
    this.trailing,
    this.boxDecoration,
    this.onTap,
  }) : super(key: key);

  final Widget leading;
  final Widget trailing;
  final Widget title;
  final Widget subtitle;
  final BoxDecoration boxDecoration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final decoration = boxDecoration ??
        BoxDecoration(
          border: Border.all(color: AppTheme.grayBorder, width: 1.5),
          borderRadius: BorderRadius.circular(6.0),
        );

    return InkWell(
      onTap: onTap,
      borderRadius: decoration.borderRadius,
      child: Container(
        height: 72,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21),
              child: leading,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (subtitle != null) subtitle,
              ],
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.only(left: 21, right: 21),
                child: trailing,
              ),
          ],
        ),
      ),
    );
  }
}
