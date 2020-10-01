import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/button/texbt_button/text_button.dart';
import 'package:pad_pal/credential/cubit/credential_cubit.dart';
import 'package:pad_pal/theme.dart';

import 'sign_in_form.dart';
import 'sign_up_form.dart';

class CredentialPage extends StatelessWidget {
  const CredentialPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CredentialPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocProvider<CredentialCubit>(
          create: (_) => CredentialCubit(
            context.repository<AuthenticationRepository>(),
          ),
          child: BlocBuilder<CredentialCubit, CredentialState>(
            buildWhen: (previous, current) => previous.view != current.view,
            builder: (context, state) {
              if (state.view == View.SignUp) {
                return _CredentialPage(
                  child: SignUpForm(),
                  text: "Sign up",
                  toggleViewButtonText: "Sign in",
                  toggleViewText: "Already have an account?",
                );
              }
              return _CredentialPage(
                child: SignInForm(),
                text: "Sign in",
                toggleViewButtonText: "Sign up",
                toggleViewText: "Don't have an account?",
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CredentialPage extends StatelessWidget {
  static const double minHeight = 12.0;
  static const Widget divider = const SizedBox(height: minHeight);

  final Widget child;
  final String text;
  final String toggleViewText;
  final String toggleViewButtonText;

  _CredentialPage({
    @required this.child,
    @required this.text,
    @required this.toggleViewText,
    @required this.toggleViewButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Expanded(
                      child: Container(),
                  ),
                  Center(
                    child: Text("PadelPal", style: AppTheme.logo),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Center(
                    child: Text(
                      this.text,
                      style: TextStyle(color: Color(0xFF172331), fontSize: 36, fontWeight: FontWeight.w700),
                    ),
                  ),
                  divider,
                  Center(
                    child: const Text(
                      "Find new padel pals and\njoin games nearby",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF959DA6), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: this.child,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  _ToggleView(
                    text: this.toggleViewText,
                    btnText: this.toggleViewButtonText,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ToggleView extends StatelessWidget {
  final text;
  final btnText;

  _ToggleView({@required this.text, @required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          this.text,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0, color: Color(0xFF959DA6)),
        ),
        TextButton(
          onPressed: () => context.bloc<CredentialCubit>().ToggleView(),
          text: this.btnText,
        ),
      ],
    );
  }
}
