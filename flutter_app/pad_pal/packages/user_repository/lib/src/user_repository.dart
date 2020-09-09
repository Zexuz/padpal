import 'package:grpc/grpc.dart';
import 'package:grpc_helpers/grpc_helpers.dart';
import 'package:user_repository/generated/user_service.pbgrpc.dart';

class Me {
  String username;
  String email;
  String firstName;
  String lastName;
}

class UserRepository {
  UserRepository({UserServiceClient userServiceClient})
      : _userServiceClient = userServiceClient ?? UserServiceClient(GrpcChannelFactory().createChannel());

  final UserServiceClient _userServiceClient;

  Future<Me> me(String accessToken) async {
    final callOptions = CallOptions(metadata: {'Authorization': "Bearer $accessToken"});
    final call = _userServiceClient.me(MeRequest(), options: callOptions);

    final protoRes = await call;
    return Me()
      ..email = protoRes.me.email
      ..username = protoRes.me.username
      ..firstName = protoRes.me.firstName
      ..lastName = protoRes.me.lastName;
  }
}
