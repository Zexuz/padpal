part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.username,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(String username) : this._(status: AuthenticationStatus.authenticated, username: username);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final String username;

  @override
  List<Object> get props => [status, username];
}
