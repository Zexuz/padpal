import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:pad_pal/bloc/authentication/authentication.dart';
import 'package:pad_pal/bloc/bloc.dart';
import 'package:pad_pal/bloc/event_filter/event_filter_cubit.dart';
import 'package:pad_pal/screens/demo/view.dart';
import 'package:pad_pal/screens/event/event_list/cubit/event_cubit.dart';
import 'package:pad_pal/screens/event/event_list/view/event_page.dart';
import 'package:pad_pal/screens/messages/messages.dart';
import 'package:pad_pal/screens/notifications/cubit/notification_cubit.dart';
import 'package:pad_pal/screens/notifications/notifications.dart';
import 'package:pad_pal/screens/profile/profile.dart';
import 'package:pad_pal/theme.dart';

class HomePage extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _BuildProfilePage extends StatelessWidget {
  const _BuildProfilePage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeCubit, MeState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading)
          return CircularProgressIndicator(
            backgroundColor: Colors.blue,
          );

        return ProfilePage(state.me);
      },
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    _BuildEventPage(),
    MessagesPage(),
    NotificationsPage(),
    _BuildProfilePage(),
    SettingsPage(),
  ];

  static const List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Events',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'Messages',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: "more",
    ),
  ];

  // TODO https://api.flutter.dev/flutter/widgets/IndexedStack-class.html
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
              create: (_) => EventFilterCubit(),
            ),
            BlocProvider(
              create: (_) => NotificationCubit(context.repository<NotificationRepository>()),
            ),
            BlocProvider(
              create: (_) => EventCubit(gameRepository: context.repository<GameRepository>()),
            )
          ],
          //_widgetOptions.elementAt(_selectedIndex)
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}

class _BuildEventPage extends StatelessWidget {
  const _BuildEventPage();

  @override
  Widget build(BuildContext context) {
    return EventPage();
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
        BlocBuilder<MeCubit, MeState>(
          buildWhen: (previous, current) => previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.isLoading) return CircularProgressIndicator();
            return Text('Name: ${context.bloc<MeCubit>().state.me.name}');
          },
        ),
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
