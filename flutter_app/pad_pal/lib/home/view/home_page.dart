import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:pad_pal/authentication/authentication.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/demo/view.dart';
import 'package:pad_pal/event/view/event_page.dart';
import 'package:pad_pal/messages/messages.dart';
import 'package:pad_pal/notifications/cubit/notification_cubit.dart';
import 'package:pad_pal/notifications/notifications.dart';
import 'package:pad_pal/profile/view/profile_page.dart';
import 'package:pad_pal/theme.dart';
import 'package:social_repository/social_repository.dart';

class HomePage extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _p = const <Widget>[
    EventPage(),
    MessagesPage(),
    NotificationsPage(),
    MyProfilePage(),
    SettingsPage(),
  ];

  static const List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Events'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      title: Text('Messages'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      title: Text('Notifications'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      title: Text('Profile'),
    ),
    BottomNavigationBarItem(icon: Icon(Icons.more_horiz), title: Text("more")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _items,
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primary,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => NotificationCubit(context.repository<NotificationRepository>()),
            ),
            BlocProvider(
              create: (_) => MeCubit(socialRepository: context.repository<SocialRepository>()),
            )
          ],
          child: _p[_selectedIndex],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return Column(
      children: [
        RaisedButton(child: Text("Components"), onPressed: () => nav.push(ComponentsPage.route())),
        Text('Name: ${context.bloc<AuthenticationBloc>().state.name}'),
        RaisedButton(
          child: const Text('Logout'),
          onPressed: () {
            context.bloc<AuthenticationBloc>().add(AuthenticationLogoutRequested());
          },
        ),
      ],
    );
  }
}
