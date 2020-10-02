import 'package:authentication_repository/authentication_repository.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:pad_pal/app_push.dart';
import 'package:pad_pal/authentication/authentication.dart';
import 'package:pad_pal/home/view/home_page.dart';
import 'package:pad_pal/splash/splash.dart';
import 'package:pad_pal/theme.dart';
import 'package:user_repository/user_repository.dart';

import 'credential/view/credential_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider(
          create: (_) => ChatRepository(),
        ),
        RepositoryProvider(
          create: (_) => NotificationRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: AppTheme.Current,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                final notificationRepo = RepositoryProvider.of<NotificationRepository>(context);
                notificationRepo.sendFmcToken(token: FirebaseTokenContainer.of(context).fcmToken);
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  CredentialPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
