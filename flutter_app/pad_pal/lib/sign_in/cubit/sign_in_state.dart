part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
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

  SignInState copyWith({
    Email email,
    Password password,
    FcmToken token,
    FormzStatus status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      fcmToken: token ?? this.fcmToken,
      status: status ?? this.status,
    );
  }
}
