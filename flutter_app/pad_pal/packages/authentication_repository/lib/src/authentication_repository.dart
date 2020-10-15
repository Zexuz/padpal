import 'dart:async';

import 'package:authentication_repository/generated/auth_v1/auth_service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:grpc_helpers/grpc_helpers.dart';

import 'token_manager.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  // TODO implement error codes here
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({AuthServiceClient authServiceClient, TokenManager tokenManager})
      : _authServiceClient = authServiceClient ?? AuthServiceClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  final _controller = StreamController<AuthenticationStatus>();

  AuthServiceClient _authServiceClient;
  TokenManager _tokenManager;

  Stream<AuthenticationStatus> get status {
    return _controller.stream;
  }

  Future<void> init() async {
    final token = await _tokenManager.getAccessToken();

    if (token == null) {
      _controller.sink.add(AuthenticationStatus.unauthenticated);
      return;
    }

    if (DateTime.now().toUtc().isBefore(token.expires)) {
      _controller.sink.add(AuthenticationStatus.authenticated);
      return;
    }

    _controller.sink.add(AuthenticationStatus.unauthenticated);
  }

  Future<void> signIn({@required String email, @required String password}) async {
    assert(email != null);
    assert(password != null);
    // myFunc(_authServiceClient.login, LoginRequest());

    var call = _authServiceClient.signIn(SignInRequest()
      ..password = password
      ..email = email);

    // var trailers = await res.trailers;

    try {
      var res = await call;
      final accessToken = _parseAccessToken(res.token);
      await _tokenManager.updateAccessToken(accessToken);
      _controller.sink.add(AuthenticationStatus.authenticated);
    } on GrpcError catch (_) {
      throw SignUpFailure();
      // if (!_canHandel(e)) rethrow;
      // _handel(e);
    }
  }

  Future<void> signUp({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    assert(email != null);
    assert(password != null);

    var call = _authServiceClient.signUp(SignUpRequest()
      ..user = (NewUser()
        ..email = email
        ..password = password
        ..name = name
        ..dateOfBirth = (NewUser_Date()
          ..year = 1996
          ..month = 11
          ..day = 7)));

    try {
      await call;
    } on GrpcError catch (_) {
      throw SignUpFailure();
    }
  }

  Future<AuthToken> refreshAccessToken(String refreshToken) async {
    assert(refreshToken != null);

    var call = _authServiceClient.getNewAccessToken(GetNewAccessTokenRequest()..refreshToken = refreshToken);

    try {
      final res = await call;
      final accessToken = _parseAccessToken(res.token);
      await _tokenManager.updateAccessToken(accessToken);
      return accessToken;
    } on GrpcError catch (_) {
      throw SignUpFailure();
    }
  }

  Future<void> logOut() async {
    await _tokenManager.destroy();
    _controller.sink.add(AuthenticationStatus.unauthenticated);
  }

  Future<void> dispose() async {
    await _controller.close();
  }

  AuthToken _parseAccessToken(OAuthToken token) {
    var accessToken = AuthToken(
        token: token.accessToken,
        refreshToken: token.refreshToken,
        expires: DateTime.fromMillisecondsSinceEpoch(token.expires.toInt() * 1000, isUtc: true));
    return accessToken;
  }
}
