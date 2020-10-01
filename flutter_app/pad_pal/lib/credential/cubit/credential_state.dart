part of 'credential_cubit.dart';

enum View { SignUp, SignIn }

class CredentialState extends Equatable {
  const CredentialState({
    this.view,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  final View view;
  final Email email;
  final Password password;
  final Name name;
  final FormzStatus status;

  @override
  List<Object> get props => [view, email, password, name, status];

  CredentialState copyWith({
    View view,
    Email email,
    Password password,
    Name name,
    FormzStatus status,
  }) {
    return CredentialState(
      view: view ?? this.view,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
