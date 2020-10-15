import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/event/event_details/view/event_details_view.dart';
import 'package:pad_pal/theme.dart';
import 'package:game_repository/src/game_repository.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({GameInfo gameInfo}) : _gameInfo = gameInfo;

  final GameInfo _gameInfo;

  @override
  Widget build(BuildContext context) {
    final top = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wed 23 Sep, 12.00-13.00 pm",
              style: TextStyle(fontSize: 12.0, color: AppTheme.secondaryColorRed),
            ),
            Text(
              "2 Spots available",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 12.0,
                  color: Colors.grey,
                ),
                Text(
                  "Delsjön Padel Center",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColorOrangeWithOpacity,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Text("3 Request", style: TextStyle(fontSize: 12.0, color: AppTheme.secondaryColorOrange)),
        )
      ],
    );

    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    const radius = 24.0;
    const padding = 3.0;

    final players = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Avatar(
          radius: radius,
          borderWidth: padding,
          url: url,
          fallback: "P1",
        ),
        const SizedBox(width: 16),
        Avatar(
          radius: radius,
          borderWidth: 0,
          url: url,
          color: Colors.white,
          fallback: "P2",
        ),
        const SizedBox(width: 16),
        DottedAvatar(radius: radius),
        const SizedBox(width: 16),
        DottedAvatar(radius: radius),
      ],
    );

    final buttons = Row(
      children: [
        Expanded(
          flex: 2,
          child: ButtonSmallPrimary(onPressed: () => <void>{}, text: 'Apply now', stretch: true, isDisabled: false),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          flex: 1,
          child: ButtonSmallSecondary(
              onPressed: () => {// Todo make card take a onDetailsClick as a ctor param
                    Navigator.of(context).push(EventDetailsView.route(context, _gameInfo)),
                  },
              text: "Details",
              stretch: true,
              isDisabled: false),
        )
      ],
    );

    return Container(
      height: 246,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          top,
          players,
          buttons,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    );
  }
}
