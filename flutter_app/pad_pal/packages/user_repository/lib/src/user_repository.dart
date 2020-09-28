import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:user_repository/generated/user_v1/user_service.pbgrpc.dart';

class Me {
  String username;
  String email;
  String firstName;
  String lastName;
}

class UserRepository {
  UserRepository({UserServiceClient userServiceClient, TokenManager tokenManager})
      : _userServiceClient = userServiceClient ?? UserServiceClient(GrpcChannelFactory().createChannel()),
        _tokenManager = tokenManager ?? TokenManager();

  final UserServiceClient _userServiceClient;
  final TokenManager _tokenManager;

  Future<Me> me() async {
    final callOptions = CallOptions(metadata: {'Authorization': "Bearer ${_tokenManager.accessToken.token}"});
    final call = _userServiceClient.me(MeRequest(), options: callOptions);

    final protoRes = await call;
    return Me()
      ..email = protoRes.me.email
      ..username = protoRes.me.username
      ..firstName = protoRes.me.firstName
      ..lastName = protoRes.me.lastName;
  }
}
