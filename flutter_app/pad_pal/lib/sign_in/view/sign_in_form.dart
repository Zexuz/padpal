import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:pad_pal/components/button/primary/button_large_primary.dart';
import 'package:pad_pal/components/button/texbt_button/text_button.dart';
import 'package:pad_pal/sign_in/cubit/sign_in_cubit.dart';
import 'package:pad_pal/sign_up/sign_up.dart';

class SignInForm extends StatelessWidget {
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
      child: ListView(
        children: [
          const SizedBox(height: 48.0),
          Center(
            child: const Text("<LOGO GOES HERE>"),
          ),
          const SizedBox(height: 48.0),
          Center(
            child: const Text(
              "Sign in",
              style: TextStyle(color: Color(0xFF172331), fontSize: 36, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 12.0),
          Center(
            child: const Text(
              "Find new padel pals and\njoin games nearby",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF959DA6), fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16.0),
          _EmailInput(),
          const SizedBox(height: 8.0),
          _PasswordInput(),
          const SizedBox(height: 8.0),
          _LoginButton(),
          const SizedBox(height: 8.0),
          _LoginDebugButton(),
          const SizedBox(height: 4.0),
          _SwitchToSignUp(),
        ],
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
            : ButtonLargePrimary(
                key: const Key('loginForm_continue_raisedButton'),
                text: 'Sign in',
                isDisabled: false,
                stretch: false,
                onPressed: state.status.isValidated ? () => context.bloc<SignInCubit>().SignInWithCredentials() : null,
              );
      },
    );
  }
}

class _LoginDebugButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                key: const Key('loginDebugForm_continue_raisedButton'),
                child: const Text('LOGIN DEBUG'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: const Color(0xFFFFD600),
                onPressed: () => context.bloc<SignInCubit>().SignInDebug(),
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
          text: "Sign in",
        ),
      ],
    );
  }
}
