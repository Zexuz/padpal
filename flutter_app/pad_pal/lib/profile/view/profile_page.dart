import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/authentication/authentication.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Name: ${context.bloc<AuthenticationBloc>().state.name}'),
          RaisedButton(
            child: const Text('Logout'),
            onPressed: () {
              context.bloc<AuthenticationBloc>().add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}
