import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/demo/view.dart';
import 'package:pad_pal/demo/view/components_page.dart';
import 'package:pad_pal/sign_in/cubit/sign_in_cubit.dart';

import 'sign_in_form.dart';

class SignInPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   actions: [
      //     FlatButton(
      //         child: const Text('Components'),
      //         onPressed: () => Navigator.push<void>(
      //               context,
      //               ComponentsPage.route(),
      //             ))
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocProvider(
          create: (_) => SignInCubit(
            context.repository<AuthenticationRepository>(),
          ),
          child: SignInForm(),
        ),
      ),
    );
  }
}
