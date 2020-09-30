part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.name,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(String name)
      : this._(status: AuthenticationStatus.authenticated, name: name);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final String name;

  @override
  List<Object> get props => [status, name];
}