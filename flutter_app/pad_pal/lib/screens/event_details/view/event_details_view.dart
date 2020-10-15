import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';

class EventDetailsView extends StatelessWidget {
  // static Route<void> route(BuildContext context) {
  //   return MaterialPageRoute<void>(
  //     builder: (_) => BlocProvider.value(
  //       value: context.bloc<EventFilterCubit>(),
  //       child: const EventFilterPage(),
  //     ),
  //   );
  // }
  static Route<void> route(BuildContext context, GameInfo gameInfo) {
    return MaterialPageRoute<void>(
      builder: (context) => EventDetailsView(gameInfo),
    );
  }

  const EventDetailsView(this.gameInfo);

  final GameInfo gameInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Details"),
      body: Center(
        child: Column(
          children: [
            Text("Id ${gameInfo.publicInfo.id}"),
            Text("Price per person ${gameInfo.publicInfo.pricePerPerson}"),
            Text("Name ${gameInfo.publicInfo.location.name}"),
            Text("Long ${gameInfo.publicInfo.location.point.longitude}"),
            Text("Lat ${gameInfo.publicInfo.location.point.latitude}"),
            Text("Court type ${gameInfo.publicInfo.courtType}"),
            Text(
                "Start time ${DateTime.fromMillisecondsSinceEpoch(gameInfo.publicInfo.startTime.toInt() * 1000)}"),
            Text("Duration ${Duration(minutes: gameInfo.publicInfo.durationInMinutes)}"),
          ],
        ),
      ),
    );
  }
}
