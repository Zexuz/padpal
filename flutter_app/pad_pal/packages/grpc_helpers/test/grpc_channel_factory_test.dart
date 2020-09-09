import 'package:flutter_test/flutter_test.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mockito/mockito.dart';
import 'package:grpc_helpers/grpc_helpers.dart';

class MockGlobalConfiguration extends Mock implements GlobalConfiguration {}

void main() {
  group('GrpcChannelFactoryTest', () {
    GrpcChannelFactory grpcChannelFactory;
    GlobalConfiguration configuration;

    setUp(() {
      configuration = MockGlobalConfiguration();
      grpcChannelFactory = GrpcChannelFactory(configuration: configuration);
    });

    test('should create new channel', () {
      when(configuration.getValue("authServiceGrpcAddress")).thenReturn("localhost");
      when(configuration.getValue("authServiceGrpcPort")).thenReturn(8080);

      final channel = grpcChannelFactory.createChannel();

      expect(channel.host, "localhost");
      expect(channel.port, 8080);
    });
  });
}
