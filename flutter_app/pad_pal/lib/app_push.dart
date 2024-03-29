import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pad_pal/services/notification/notification_service.dart';

class FirebaseTokenContainer extends InheritedWidget {
  const FirebaseTokenContainer({
    Key key,
    this.fcmToken,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final String fcmToken;

  static FirebaseTokenContainer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FirebaseTokenContainer>();
  }

  @override
  bool updateShouldNotify(FirebaseTokenContainer old) => fcmToken != old.fcmToken;
}

class AppPush extends StatefulWidget {
  AppPush({
    @required this.child,
  });

  final Widget child;

  @override
  _AppPushState createState() => _AppPushState();
}

class _AppPushState extends State<AppPush> {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final NotificationManager _notificationManager = NotificationManager();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _fcmToken = null;

  @override
  initState() {
    super.initState();
    _initLocalNotifications();
    _initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseTokenContainer(child: widget.child, fcmToken: _fcmToken);
  }

  _initLocalNotifications() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  _initFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        try {
          print('AppPushs onMessage : $message');
          _handleNotification(message);
        } catch (e) {
          print(e);
        }

        //_showNotification(message);
        return;
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) {
        print('AppPushs onResume : $message');
        if (Platform.isIOS) {
          _showNotification(message);
        }
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('AppPushs onLaunch : $message');
        return;
      },
    );
    _firebaseMessaging.getToken().then((value) {
      print('FCM token: $value');
      setState(() {
        _fcmToken = value;
      });
    });
    _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  // TOP-LEVEL or STATIC function to handle background messages
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    print('AppPushs myBackgroundMessageHandler : $message');
    _showNotification(message);
    return Future<void>.value();
  }

  void _handleNotification(Map<String, dynamic> message) {
    var type = message["data"]["type"];
    switch (type) {
      case 'chat-message':
        _notificationManager.addChatNotification(message["data"]["content"]);
        break;
      default:
        throw Exception("Unknown type $type");
    }
  }

  static Future _showNotification(Map<String, dynamic> message) async {
    var pushTitle;
    var pushText;
    var action;

    if (Platform.isAndroid) {
      var nodeData = message['data'];
      pushTitle = nodeData['title'];
      pushText = nodeData['body'];
      action = nodeData['action'];
    } else {
      pushTitle = message['title'];
      pushText = message['body'];
      action = message['action'];
    }
    print("AppPushs params pushTitle : $pushTitle");
    print("AppPushs params pushText : $pushText");
    print("AppPushs params pushAction : $action");

    var platformChannelSpecificsAndroid = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      playSound: false,
      enableVibration: false,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var platformChannelSpecificsIos = new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics =
        new NotificationDetails(platformChannelSpecificsAndroid, platformChannelSpecificsIos);

    new Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        pushTitle,
        pushText,
        platformChannelSpecifics,
        payload: 'No_Sound',
      );
    });
  }
}
