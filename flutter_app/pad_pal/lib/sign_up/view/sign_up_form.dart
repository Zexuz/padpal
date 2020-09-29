import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pad_pal/components/button/primary/button_large_primary.dart';
import 'package:pad_pal/components/button/texbt_button/text_button.dart';
import 'package:pad_pal/sign_in/signIn.dart';
import 'package:pad_pal/sign_up/cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
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
              "Sign up",
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
          const SizedBox(height: 38.0),
          _NameInput(),
          const SizedBox(height: 12.0),
          _UsernameInput(),
          const SizedBox(height: 12.0),
          _EmailInput(),
          const SizedBox(height: 12.0),
          _PasswordInput(),
          const SizedBox(height: 24.0),
          _SignUpButton(),
          const SizedBox(height: 12.0),
          _SwitchToSignIn(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.bloc<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) => context.bloc<SignUpCubit>().passwordChanged(password),
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

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (password) => context.bloc<SignUpCubit>().usernameChanged(password),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.find_replace),
            errorText: state.password.invalid ? 'invalid username' : null,
            border: OutlineInputBorder(),
            labelText: "Username",
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_nameInput_textField'),
          onChanged: (firstName) => context.bloc<SignUpCubit>().nameChanged(firstName),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ButtonLargePrimary(
                key: const Key('signUpForm_continue_raisedButton'),
                text: 'Sign up',
                isDisabled: false,
                stretch: false,
                onPressed: state.status.isValidated ? () => context.bloc<SignUpCubit>().signUpFormSubmitted() : null,
              );
      },
    );
  }
}

class _SwitchToSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0, color: Color(0xFF959DA6)),
        ),
        TextButton(
          onPressed: () => Navigator.push<void>(
            context,
            SignInPage.route(),
          ),
          text: "Sign in",
        ),
      ],
    );
  }
}
