import 'package:flutter/material.dart';
import 'package:pad_pal/credential/components/EmailInput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/credential/components/PasswordInput.dart';
import 'package:pad_pal/credential/cubit/credential_cubit.dart';
import 'package:formz/formz.dart';

class SignInForm extends StatelessWidget {
  static const double minHeight = 12.0;
  static const Widget divider = const SizedBox(height: minHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailInput(),
        divider,
        PasswordInput(),
        divider,
        _ForgotPassword(),
        divider,
        _LoginButton(),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialCubit, CredentialState>(
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
            state.status.isValidated ? () => context.bloc<CredentialCubit>().SignInWithCredentials() : null,
          ),
        );
      },
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
        child: Text('Forgot password?'),
        onPressed: () => {},
      ),
    );
  }
}
