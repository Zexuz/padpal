import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/profile/view/profile_search_view.dart';
import 'package:pad_pal/theme.dart';
import 'package:social_repository/social_repository.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage();

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final profile = getMyProfile();

    return Scaffold(
      appBar: CustomAppBar(title: profile.name, actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            nav.push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ProfileSearchView(),
            ));
          },
        )
      ]),
      backgroundColor: Colors.white,
      body: ProfileView(
        profile: profile,
        isMe: true,
        areWeFriends: false,
      ),
    );
  }

  Profile getMyProfile() {
    return Profile()
      ..name = "Robin Oliver Edbom"
      ..rank = "Beginner + + +"
      ..friends = 1337
      ..imageUrl = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg"
      ..losses = 25
      ..wins = 75
      ..location = "Göteborg";
  }
}

class ProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage());
  }

  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    final profile = getUsersProfile();

    return Scaffold(
      appBar: CustomAppBar(title: profile.name),
      backgroundColor: Colors.white,
      body: ProfileView(
        profile: profile,
        isMe: false,
        areWeFriends: true,
      ),
    );
  }

  Profile getUsersProfile() {
    return Profile()
      ..name = "LOOKUP USER"
      ..rank = "Beginner + + +"
      ..friends = 1337
      ..imageUrl = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg"
      ..losses = 25
      ..wins = 75
      ..location = "Göteborg";
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({this.profile, this.isMe, this.areWeFriends});

  final Profile profile;
  final bool isMe;
  final bool areWeFriends;

  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final row = Row(children: []);
    if (!this.isMe) {
      if (this.areWeFriends) {
        row.children.add(Expanded(
          child: ButtonSmallLight(onPressed: () {}, text: "Friends", stretch: false, isDisabled: false),
        ));
        row.children.add(const SizedBox(width: 8,));
        row.children.add(Expanded(
          child: ButtonSmallPrimary(onPressed: () {}, text: "Chat", stretch: false, isDisabled: false),
        ));
      } else {
        row.children.add(Expanded(
          child: ButtonSmallPrimary(onPressed: () {}, text: "Add friend", stretch: false, isDisabled: false),
        ));
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: displayWidth(context) * 0.08),
            child: Avatar(
              radius: displayWidth(context) * 0.15,
              borderWidth: displayWidth(context) * 0.015,
              url: this.profile.imageUrl,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: displayHeight(context) * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: AppTheme.lightGrayBackground,
                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                child: Text(this.profile.rank,
                    style: theme.textTheme.subtitle2
                        .copyWith(color: AppTheme.lightGrayText, fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: displayWidth(context) * 0.03),
            child: Text(
              this.profile.name,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: displayWidth(context) * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: AppTheme.lightGrayText, size: 12),
                Text(this.profile.location,
                    style: theme.textTheme.subtitle2.copyWith(color: AppTheme.lightGrayText, fontSize: 12))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: displayWidth(context) * 0.04,
                left: displayWidth(context) * 0.08,
                right: displayWidth(context) * 0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatsCountWithLabel(count: this.profile.wins, label: "Wins"),
                _StatsCountWithLabel(count: this.profile.losses, label: "Losses"),
                _StatsCountWithLabel(count: this.profile.friends, label: "Friends"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: displayWidth(context) * 0.04,
                left: displayWidth(context) * 0.08,
                right: displayWidth(context) * 0.08),
            child: row,
          ),
        ],
      ),
    );
  }
}

class _StatsCountWithLabel extends StatelessWidget {
  const _StatsCountWithLabel({
    @required this.count,
    @required this.label,
  });

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.23;
    return Container(
      width: width,
      child: Column(
        children: [
          Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          Text(label,
              style: TextStyle(
                color: AppTheme.lightGrayText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
