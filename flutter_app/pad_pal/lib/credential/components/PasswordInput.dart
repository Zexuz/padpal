import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_pal/credential/cubit/credential_cubit.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredentialCubit, CredentialState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          onChanged: (password) => context.bloc<CredentialCubit>().passwordChanged(password),
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