import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AccessToken extends Equatable {
  final String token;
  final DateTime expires;

  const AccessToken({
    @required this.token,
    @required this.expires,
  }) : assert(token != null);

  @override
  List<Object> get props => [token, expires];
}

class TokenManager{
  static TokenManager _singleton = TokenManager._internal();

  factory TokenManager() {
    return _singleton;
  }

  TokenManager._internal();


  AccessToken accessToken;
}