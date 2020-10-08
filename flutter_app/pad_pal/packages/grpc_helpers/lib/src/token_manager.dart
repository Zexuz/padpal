import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:protobuf/protobuf.dart';

class AuthToken extends Equatable {
  final String token;
  final DateTime expires;
  final String refreshToken;

  const AuthToken({
    @required this.token,
    @required this.expires,
    @required this.refreshToken,
  }) : assert(token != null);

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['token'],
      expires: DateTime.parse(json['expires']),
      refreshToken: json['refreshToken'],
    );
  }

  @override
  List<Object> get props => [token];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
      'expires': expires.toIso8601String(),
      'refreshToken': refreshToken,
    };
  }
}

class TokenManager {
  static TokenManager _singleton = TokenManager._internal();
  static FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _accessTokenKey = "accessToken";

  factory TokenManager() {
    return _singleton;
  }

  TokenManager._internal();

  Future<void> updateAccessToken(AuthToken accessToken) async {
    await _storage.write(key: _accessTokenKey, value: jsonEncode(accessToken.toJson()));
  }

  Future<AuthToken> getAccessToken() async {
    try {
      var rawJson = await _storage.read(key: _accessTokenKey);
      return AuthToken.fromJson(jsonDecode(rawJson));
    } catch (e) {
      return null;
    }
  }

  Future<void> destroy() async {
    await _storage.deleteAll();
  }
}
