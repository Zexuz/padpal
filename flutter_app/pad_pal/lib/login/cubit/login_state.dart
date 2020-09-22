part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.fcmToken = const FcmToken.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FcmToken fcmToken;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, fcmToken, status];

  LoginState copyWith({
    Email email,
    Password password,
    FcmToken token,
    FormzStatus status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      fcmToken: token ?? this.fcmToken,
      status: status ?? this.status,
    );
  }
}
