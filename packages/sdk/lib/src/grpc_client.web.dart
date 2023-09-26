// ignore_for_file: implementation_imports

import 'package:grpc/service_api.dart' as grpc;
import 'package:grpc/src/client/call.dart';
import 'package:grpc/src/client/connection.dart';

class GrpcWebClientChannel extends grpc.ClientChannel {
  final Uri uri;

  GrpcWebClientChannel.xhr(this.uri) : super();

  @override
  ClientCall<Q, R> createCall<Q, R>(grpc.ClientMethod<Q, R> method,
      Stream<Q> requests, grpc.CallOptions options) {
    // TODO: implement createCall
    throw UnimplementedError();
  }

  @override
  // TODO: implement onConnectionStateChanged
  Stream<ConnectionState> get onConnectionStateChanged =>
      throw UnimplementedError();

  @override
  Future<void> shutdown() {
    // TODO: implement shutdown
    throw UnimplementedError();
  }

  @override
  Future<void> terminate() {
    // TODO: implement terminate
    throw UnimplementedError();
  }
}
