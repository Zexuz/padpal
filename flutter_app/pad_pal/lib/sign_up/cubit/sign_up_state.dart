part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const Username.pure(),
    this.name = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final Username username;
  final Name name;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, username, name, status];

  SignUpState copyWith({
    Email email,
    Password password,
    Username username,
    Name name,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
