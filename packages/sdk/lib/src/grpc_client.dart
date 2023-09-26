import 'grpc_client.web.dart'
    if (dart.library.html) 'package:grpc/grpc_web.dart'
    show GrpcWebClientChannel;
import 'package:grpc/service_api.dart' as grpc;
import 'package:grpc/grpc.dart';

typedef Channel = grpc.ClientChannel;

Channel createChannel(
    {required bool isGrpcWeb,
    required String host,
    required int port,
    String userAgent = 'milkapis_client_dart',
    void Function()? channelShutdownHandler}) {
  return isGrpcWeb
      ? GrpcWebClientChannel.xhr(Uri.parse(
          '${port == 443 ? 'https' : 'http'}://$host${(port == 443 || port == 80) ? '' : ':$port'}'))
      : ClientChannel(host,
          port: port,
          channelShutdownHandler: channelShutdownHandler,
          options: ChannelOptions(
              codecRegistry: CodecRegistry(codecs: const [
                GzipCodec(),
                IdentityCodec(),
              ]),
              keepAlive: ClientKeepAliveOptions(
                  pingInterval: Duration(milliseconds: 25000),
                  permitWithoutCalls: true),
              credentials: port == 443
                  ? const ChannelCredentials.secure()
                  : const ChannelCredentials.insecure(),
              userAgent: userAgent));
}
