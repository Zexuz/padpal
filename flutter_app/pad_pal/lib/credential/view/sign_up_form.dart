import 'package:flutter/material.dart';
import 'package:pad_pal/credential/components/EmailInput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/credential/components/PasswordInput.dart';
import 'package:pad_pal/credential/cubit/credential_cubit.dart';
import 'package:formz/formz.dart';

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
                child: ButtonLargePrimary(
                  text: 'Sign up',
                  isDisabled: false,
                  stretch: false,
                  onPressed:
                      state.status.isValidated ? () => context.bloc<CredentialCubit>().signUpFormSubmitted() : null,
                ),
              );
      },
    );
  }
}
