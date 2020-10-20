import 'package:global_configuration/global_configuration.dart';
import 'package:grpc/grpc.dart';

class GrpcChannelFactory {
  GrpcChannelFactory({GlobalConfiguration configuration}) : _configuration = configuration ?? GlobalConfiguration();

  GlobalConfiguration _configuration;

  ClientChannel createChannel() {
    final host = _configuration.getValue<String>("authServiceGrpcAddress");
    final port = _configuration.getValue<int>("authServiceGrpcPort");

    // TODO In prod use app version in the useragent
    final userAgent = _configuration.getValue<String>("userAgent");

    // TODO DON'T create a new channel if one already exists.
    return ClientChannel(host,
        port: port,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          userAgent: userAgent,
        ));
  }
}
