import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:pad_pal/components/button/light/button_small_light.dart';
import 'package:pad_pal/components/button/primary/button_large_primary.dart';
import 'package:pad_pal/components/button/texbt_button/text_button.dart';
import 'package:pad_pal/sign_in/cubit/sign_in_cubit.dart';
import 'package:pad_pal/sign_up/sign_up.dart';
import 'package:pad_pal/theme.dart';

class SignInForm extends StatelessWidget {
  static const double minHeight = 12.0;
  static const Widget divider = const SizedBox(height: minHeight);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: LayoutBuilder(
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
                      child: const Text(
                        "Sign in",
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
                    _EmailInput(),
                    divider,
                    _PasswordInput(),
                    divider,
                    _ForgotPassword(),
                    divider,
                    _LoginButton(),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    _SwitchToSignUp(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.bloc<SignInCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
            labelText: 'Email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.bloc<SignInCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.lock),
            errorText: state.password.invalid ? 'invalid password' : null,
            border: OutlineInputBorder(),
            labelText: "Password",
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ButtonLargePrimary(
                  key: const Key('loginForm_continue_raisedButton'),
                  text: 'Sign in',
                  isDisabled: false,
                  stretch: false,
                  onPressed:
                      state.status.isValidated ? () => context.bloc<SignInCubit>().SignInWithCredentials() : null,
                ),
              );
      },
    );
  }
}

class _SwitchToSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Don’t have an account yet?",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0, color: Color(0xFF959DA6)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
          text: "Sign up",
        ),
      ],
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        key: const Key('loginForm_forgot_password_raisedButton'),
        text: 'Forgot password?',
        onPressed: () => {},
      ),
    );
  }
}
