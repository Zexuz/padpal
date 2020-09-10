part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const Username.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final Username username;
  final Name firstName;
  final Name lastName;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, username, firstName, lastName, status];

  SignUpState copyWith({
    Email email,
    Password password,
    Username username,
    Name firstName,
    Name lastName,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
    );
  }
}
