import 'package:flutter/material.dart';
import 'package:pad_pal/event/view/event_page.dart';
import 'package:pad_pal/messages/messages.dart';
import 'package:pad_pal/notifications/notifications.dart';
import 'package:pad_pal/profile/view/profile_page.dart';
import 'package:pad_pal/theme.dart';

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
    ProfilePage(),
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
        // child: _pages(_selectedIndex),
        child: _p[_selectedIndex],
      ),
    );
  }
}
