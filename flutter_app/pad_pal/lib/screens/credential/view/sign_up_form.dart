import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:formz/formz.dart';

import '../components/EmailInput.dart';
import '../components/PasswordInput.dart';
import '../cubit/credential_cubit.dart';

class SignUpForm extends StatelessWidget {
  static const double minHeight = 12.0;
  static const Widget divider = const SizedBox(height: minHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NameInput(),
        divider,
        EmailInput(),
        divider,
        PasswordInput(),
        divider,
        divider,
        _SignUpButton(),
      ],
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialCubit, CredentialState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name.value,
          onChanged: (firstName) => context.bloc<CredentialCubit>().nameChanged(firstName),
          decoration: InputDecoration(
            suffixIcon: Icon((Icons.account_box)),
            border: OutlineInputBorder(),
            labelText: 'Full name',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialCubit, CredentialState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: Button.primary(
                  child: Text('Sign up'),
                  onPressed:
                      state.status.isValidated ? () => context.bloc<CredentialCubit>().signUpFormSubmitted() : null,
                ),
              );
      },
    );
  }
}
