import 'dart:async';

import 'package:authentication_repository/generated/auth_service.pbgrpc.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import 'package:meta/meta.dart';
import 'package:grpc_helpers/grpc_helpers.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  // TODO implement error codes here
}

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

class TokenStorage {
  static final TokenStorage _instance = TokenStorage._();

  AccessToken accessToken;

  factory TokenStorage() {
    return _instance;
  }

  TokenStorage._();
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({AuthServiceClient authServiceClient, TokenStorage tokenStorage})
      : _authServiceClient = authServiceClient ?? AuthServiceClient(GrpcChannelFactory().createChannel()),
        _tokenStorage = tokenStorage ?? TokenStorage._instance;

  final _controller = StreamController<AuthenticationStatus>();

  AuthServiceClient _authServiceClient;
  TokenStorage _tokenStorage;

  Future<String> get accessToken async {
    return ""; // TODO check if the token has expiered, if it has, renewit with the refreshToken
  }

  Stream<AuthenticationStatus> get status {
    return _controller.stream;
  }

  void init() {
    _controller.sink.add(AuthenticationStatus.unauthenticated);
  }

  Future<void> login({@required email, @required String password}) async {
    assert(email != null);
    assert(password != null);
    // myFunc(_authServiceClient.login, LoginRequest());

    var call = _authServiceClient.login(LoginRequest()
      ..password = password
      ..email = email);

    // var trailers = await res.trailers;

    try {
      var res = await call;
      var accessToken = AccessToken(
          token: res.token.accessToken,
          expires: DateTime.fromMillisecondsSinceEpoch(res.token.expires.toInt() * 1000, isUtc: true));
      // expires: null);
      _tokenStorage.accessToken = accessToken;
      _controller.sink.add(AuthenticationStatus.authenticated);
    } on GrpcError catch (_) {
      throw SignUpFailure();
      // if (!_canHandel(e)) rethrow;
      // _handel(e);
    }
  }

  Future<void> logOut() {
    // TODO IMPLEMENT
    _controller.sink.add(AuthenticationStatus.unauthenticated);
    // throw Exception("NOT IMPLEMENTED");
  }

  // bool _canHandel(GrpcError e) {
  //   return true;
  // }
  //
  // void _handel(GrpcError e) {
  //   throw SignUpFailure();
  // }

  Future<void> dispose() async {
    await _controller.close();
  }

// Future<void> myFunc<TResponse, TRequest>(ResponseFuture<TResponse> Function(TRequest request, {CallOptions options}) method, TRequest request) async {
//   var call = method(request, options: CallOptions(metadata: {'peer': 'Verner'})); // TODO add AUTH
//
//   var trailers = await call.trailers;
//
//   return await call;
// }
}

// import 'dart:async';
//
// import 'package:meta/meta.dart';
// import 'package:grpc/grpc.dart';
//
// import '../generated/auth_service.pbgrpc.dart';
//
// enum AuthenticationStatus { unknown, authenticated, unauthenticated }
//
// class AuthenticationRepository {
//   AuthenticationRepository({
//     AuthServiceClient authServiceClient,
//   }) : _authServiceClient = authServiceClient ??
//       AuthServiceClient(
//           ClientChannel('192.168.10.240',
//               port: 5001, options: const ChannelOptions(credentials: ChannelCredentials.insecure())),
//           options: CallOptions(timeout: Duration(seconds: 30)));
//
//   final _controller = StreamController<AuthenticationStatus>();
//   final AuthServiceClient _authServiceClient;
//
//   Stream<AuthenticationStatus> get status async* {
//     await Future<void>.delayed(const Duration(seconds: 1));
//     yield AuthenticationStatus.unauthenticated;
//     yield* _controller.stream;
//   }
//
//   Future<void> logIn({
//     @required String username,
//     @required String password,
//   }) async {
//     assert(username != null);
//     assert(password != null);
//
//     var res = await _authServiceClient.login(LoginRequest()
//       ..email = "r@a.com"
//       ..password = "pw");
//     print(res.token.accessToken);
//
//     await Future.delayed(
//       const Duration(milliseconds: 300),
//           () => _controller.add(AuthenticationStatus.authenticated),
//     );
//   }
//
//   void logOut() {
//     _controller.add(AuthenticationStatus.unauthenticated);
//   }
//
//   void dispose() => _controller.close();
// }
