import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/view.dart';
import 'package:pad_pal/login/cubit/login_cubit.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          FlatButton(
              child: Text("Components"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComponentsPage()),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => LoginCubit(
            context.repository<AuthenticationRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
