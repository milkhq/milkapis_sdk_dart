import 'package:flutter/foundation.dart';

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
  final isUnsecure = host.startsWith('192.168.1') ||
      host.startsWith('localhost') ||
      host.startsWith('127.0.0.1');
  return isGrpcWeb
      ? GrpcWebClientChannel.xhr(
          Uri.parse('${isUnsecure ? 'http' : 'https'}://$host:$port'))
      : ClientChannel(host,
          port: port,
          channelShutdownHandler: channelShutdownHandler,
          options: ChannelOptions(
              codecRegistry: CodecRegistry(codecs: const [
                GzipCodec(),
                IdentityCodec(),
              ]),
              credentials: isUnsecure
                  ? const ChannelCredentials.insecure()
                  : const ChannelCredentials.secure(),
              userAgent: userAgent));
}
