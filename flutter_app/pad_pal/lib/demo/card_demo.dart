import 'package:flutter/material.dart';
import 'package:pad_pal/components/buttons.dart';
import 'package:pad_pal/demo/avatar_demo.dart';
import 'package:pad_pal/theme.dart';

class CardDemo extends StatelessWidget {
  const CardDemo();

  @override
  Widget build(BuildContext context) {
    final entries = [
      CustomCard(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Demo'),
      ),
      backgroundColor: Color(0xFFDDE2E9),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return entries[index];
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
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
          child: Text("3 Request",
              style: TextStyle(fontSize: 12.0, color: AppTheme.secondaryColorOrange)),
        )
      ],
    );

    final players = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LeaderAvatar(),
        const SizedBox(width: 16),
        Avatar(),
        const SizedBox(width: 16),
        DottedAvatar(),
        const SizedBox(width: 16),
        DottedAvatar(),
      ],
    );

    final buttons = Row(
      children: [
        Expanded(
          flex: 2,
          child: ButtonSmallPrimary(
              onPressed: () => <void>{}, text: 'Apply now', stretch: true, isDisabled: false),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          flex: 1,
          child: ButtonSmallSecondary(
              onPressed: () => <void>{}, text: "Details", stretch: true, isDisabled: false),
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
