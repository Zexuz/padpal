import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:pad_pal/app.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
  ));
}
