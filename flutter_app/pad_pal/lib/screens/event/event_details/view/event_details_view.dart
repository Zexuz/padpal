import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/button/primary/button_large_primary.dart';
import 'package:pad_pal/screens/event/components/components.dart';
import 'package:pad_pal/screens/event/create_event/view/create_event_add_players_step.dart';
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
                  EventStepTitle(title: "Information", subtitle: "Message from Anton:"),
                  RichText(
                    text: TextSpan(
                      text: 'Hi guys! \n\n'

                        'Me and my friend Andries are new to this sport and we are looking for two players bla bla bla...',
                      style: theme.textTheme.bodyText1
                    ),
                  ),
                  ButtonLargePrimary(onPressed: null,text: "Go to group chat",)
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

  @override
  Widget build(BuildContext context) {
    final meCubit = context.bloc<MeCubit>();

    const radius = 24.0;

    const offset = (radius * 2);

    return Column(
      children: [
        Price(gameInfo: gameInfo),
        EventStepTitle(title: "Players", subtitle: "Lorem ipsom dolar sit amet"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreatorSpot(
              profile: meCubit.state.me,
              radius: radius,
              offset: offset,
            ),
            PendingSpot(
              profile: meCubit.state.me,
              radius: radius,
              offset: offset,
            ),
            FreeSpot(
              radius: radius,
              offset: offset,
              onTap: () => print("Tapped Invite"),
              playerNumber: 3,
            ),
            FreeSpot(
              radius: radius,
              offset: offset,
              onTap: () => print("Tapped Invite"),
              playerNumber: 4,
              addDivider: false,
            ),
          ],
        ),
      ],
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
            EventStepTitle(title: "Details", subtitle: "Lorem ipsom dolar sit amet"),
            ListTile(
              title: Text("Wed 23 Sep, 12.00-13.00 pm"),
              subtitle: Text("Next week"),
              leading: Icon(Icons.calendar_today, color: Color(0xFFB4BEC9)),
            ),
            ListTile(
              title: Text("Delsjön Padel Center"),
              subtitle: Text("Göteborg"),
              leading: Icon(Icons.place, color: Color(0xFFB4BEC9)),
            ),
            ListTile(
              title: Text("9 (hall C)"),
              subtitle: Text("Court number"),
              leading: Icon(Icons.directions, color: Color(0xFFB4BEC9)),
            ),
            ListTile(
              title: Text(gameInfo.publicInfo.courtType.toString()),
              subtitle: Text("Lorem ipsum"),
              leading: Icon(Icons.house, color: Color(0xFFB4BEC9)),
            ),
            ListTile(
              title: Text("${gameInfo.publicInfo.pricePerPerson} kr"),
              subtitle: Text("Price per person"),
              leading: Icon(Icons.label, color: Color(0xFFB4BEC9)),
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

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryColorOrangeWithOpacity,
        border: Border.all(color: AppTheme.secondaryColorOrange, width: 1.5),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: ListTile(
        leading: Icon(
          Icons.label,
          color: AppTheme.secondaryColorOrange,
        ),
        title: Text("${gameInfo.publicInfo.pricePerPerson} kr", style: theme.textTheme.subtitle1),
        subtitle: Text(
          "Price per person",
          style: theme.textTheme.caption.copyWith(color: AppTheme.secondaryColorOrange),
        ),
      ),
    );
  }
}
